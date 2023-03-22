import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final List<String> imgUrls = [];

  Future<List<String>> _uploadImages(List<File> imageFiles) async {
    final List<String> downloadUrls = [];
    for (File imageFile in imageFiles) {
      final Reference storageRef = storage
          .ref()
          .child('assets/images/avatar/${DateTime.now().millisecondsSinceEpoch}');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      print(url);
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  Future<void> _pickImages() async {
    final List<PickedFile>? pickedImages =
    await ImagePicker().getMultiImage(); // use getMultiImage instead of getImage
    if (pickedImages != null) {
      List<File> files = pickedImages.map((PickedFile pickedImage) => File(pickedImage.path)).toList();
      final List<String> downloadUrls = await _uploadImages(files);
      setState(() {
        imgUrls.addAll(downloadUrls);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Images'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: imgUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(imgUrls[index]);
              },
            ),
          ),
          ElevatedButton(
            onPressed: _pickImages,
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.camera_alt),
                SizedBox(width: 8.0),
                Text('Pick Image'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
