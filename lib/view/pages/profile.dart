
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:second_hand_app/authentication/auth_service.dart';
import 'package:second_hand_app/utils/text_string.dart';
import 'package:second_hand_app/view/pages/update_profile.dart';


import '../widget/profile_menu.dart';

class Profile extends StatelessWidget {
  Profile({Key? key, this.pickedFile}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future<void> selectFile(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => Profile(pickedFile: result.files.first)));
  }

  Future uploadFile() async {
    final path = 'assets/images/avatar/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');
  }



  @override
  Widget build(BuildContext context) {

    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? tPrimaryColor : tAccentColor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {}, icon: const Icon(LineAwesomeIcons.angle_left)),
        title: const Text(tProfile),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 95,
                    height: 95,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(FirebaseAuth.instance.currentUser!.photoURL!)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor
                      ),
                      child:const Icon(LineAwesomeIcons.alternate_pencil, size: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text( FirebaseAuth.instance.currentUser!.displayName!,
                style:
                const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              Text(FirebaseAuth.instance.currentUser!.email!,
                style: const TextStyle(fontSize: 16),),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor, side: BorderSide.none, shape: const StadiumBorder()),
                  child: const Text(tEditProfile, style: TextStyle(color: tDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              //MENU
              ProfileMenuWidget(title: "Settings", icon: LineAwesomeIcons.cog, onPress: () {}),
              ProfileMenuWidget(title: "Billing Details", icon: LineAwesomeIcons.wallet, onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: LineAwesomeIcons.user_check, onPress: () {}),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: LineAwesomeIcons.info, onPress: () {}),
              ProfileMenuWidget(title: "Logout", icon: LineAwesomeIcons.alternate_sign_out,  textColor: Colors.red, endIcon: false, onPress: () {AuthService().signOut();},),
            ],
          ),
        ),
      ),
    );
  }
}


