import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:second_hand_app/model/drop_list_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../widget/my_dropdown_menu.dart';

class PostingPost extends StatefulWidget {
  const PostingPost({Key? key}) : super(key: key);

  @override
  State<PostingPost> createState() => _PostingPostState();
}

class _PostingPostState extends State<PostingPost> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  HtmlEditorController htmlEditorController = HtmlEditorController();
  List<String> imgIds = [];
  String _title = ''; // define the _title variable
  String _productName = ''; // define the _title variable
  String _price = ''; // define the _price variable

  DropdownItem? _selectedItem;

  void _onDropdownItemSelected(DropdownItem? selectedItem) {
    setState(() {
      _selectedItem = selectedItem;
    });
  }

  Future<void> createNewPost() async {
    final url =
        Uri.parse('https://secondhandvinhome.herokuapp.com/api/post/create');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        // add any additional headers you may need
      },
      body: jsonEncode({
        'title': _title,
        // replace with the title you want to send
        'productName': _productName,
        // replace with the title you want to send
        'price': _price,
        // replace with the price you want to send
        'category': _selectedItem,
        // replace with the selected category value
        'description': htmlEditorController.getText(),
        // replace with the description text
        'imgIds': imgIds,
        // replace with the list of image IDs
      }),
    );

    if (response.statusCode == 200) {
      // post created successfully, handle the response
      print('Post created successfully!');
      // show a snackbar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post created successfully!'),
        ),
      );
    } else {
      // something went wrong, handle the error
      print('Error creating post: ${response.statusCode}');
      // show a snackbar to indicate the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating post: ${response.statusCode}'),
        ),
      );
    }
  }

  final FirebaseStorage storage = FirebaseStorage.instance;
  final List<String> imgUrls = [];

  Future<List<String>> _uploadImages(List<File> imageFiles) async {
    final List<String> downloadUrls = [];
    for (File imageFile in imageFiles) {
      final Reference storageRef = storage.ref().child(
          'assets/images/avatar/${DateTime.now().millisecondsSinceEpoch}.png');
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot downloadUrl = await uploadTask;
      final String url = await downloadUrl.ref.getDownloadURL();
      print(url);
      downloadUrls.add(url);
    }
    return downloadUrls;
  }

  Future<void> _pickImages() async {
    final List<PickedFile>? pickedImages = await ImagePicker()
        .getMultiImage(); // use getMultiImage instead of getImage
    if (pickedImages != null) {
      List<File> files = pickedImages
          .map((PickedFile pickedImage) => File(pickedImage.path))
          .toList();
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
        title: const Text('Posting Post'),
      ),
      body: Form(
        key: globalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    prefixIcon: const Icon(Icons.web),
                    "title",
                    "Title Of Post",
                    "",
                    (onValidateVal) {
                      if (onValidateVal!.isEmpty) {
                        return 'Title is required.';
                      }

                      return null;
                    },
                    (onSavedVal) {
                      _title = onSavedVal!;
                    },
                    initialValue: _title,
                    borderColor: Theme.of(context).primaryColor,
                    borderFocusColor: Theme.of(context).primaryColor,
                    borderRadius: 10,
                    paddingLeft: 0,
                    paddingRight: 0,
                    showPrefixIcon: false,
                    onChange: (val) {},
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    prefixIcon: const Icon(Icons.web),
                    "productName",
                    "Product Name",
                    "",
                    (onValidateVal) {
                      if (onValidateVal!.isEmpty) {
                        return 'Product Name is required.';
                      }

                      return null;
                    },
                    (onSavedVal) {
                      _productName = onSavedVal!;
                    },
                    initialValue: _productName,
                    borderColor: Theme.of(context).primaryColor,
                    borderFocusColor: Theme.of(context).primaryColor,
                    borderRadius: 10,
                    paddingLeft: 0,
                    paddingRight: 0,
                    showPrefixIcon: false,
                    onChange: (val) {},
                  ),
                ),

                Row(
                  children: [
                    Flexible(
                      child: FormHelper.inputFieldWidgetWithLabel(
                        context,
                        prefixIcon: const Icon(Icons.wallet_giftcard),
                        "price",
                        "Price",
                        "",
                        (onValidateVal) {
                          if (onValidateVal!.isEmpty) {
                            return 'Price of Product is required.';
                          }

                          return null;
                        },
                        (onSavedVal) {
                          _price = onSavedVal!;
                        },
                        initialValue: _price,
                        showPrefixIcon: false,
                        borderColor: Theme.of(context).primaryColor,
                        borderFocusColor: Theme.of(context).primaryColor,
                        borderRadius: 10,
                        paddingLeft: 0,
                        paddingRight: 0,
                        suffixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "\$",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        onChange: (val) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                MyDropdownMenu(onItemSelected: _onDropdownItemSelected),

                const SizedBox(
                  height: 20,
                ),

                HtmlEditor(
                  controller: htmlEditorController,
                  htmlEditorOptions: const HtmlEditorOptions(
                    hint: "Product Description",
                  ),
                  htmlToolbarOptions: const HtmlToolbarOptions(
                    toolbarPosition: ToolbarPosition.aboveEditor,
                    toolbarType: ToolbarType.nativeGrid,
                    defaultToolbarButtons: [FontButtons()],
                  ),
                  otherOptions: const OtherOptions(
                    height: 400,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  child: Text(
                    "Product Image",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                imgUrls.isEmpty ? const SizedBox() :
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 1,
                    ),
                    itemCount: imgUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Image.network(
                          imgUrls[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: _pickImages,
                    child: const Text("Pick Image"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          globalKey.currentState!.save();
                          createNewPost();
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
