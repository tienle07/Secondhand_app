import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/cart.dart';
import 'package:second_hand_app/pages/home.dart';
import 'package:second_hand_app/pages/profile.dart';
import 'package:second_hand_app/pages/saved.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomePage(),
    const Cart(),
    const Saved(),
    const Profile(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        splashColor: Colors.amberAccent,
        onPressed: () {},
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Cart();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: currentTab == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Cart',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
              // Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Saved();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Saved',
                          style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:io';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:second_hand_app/authentication/auth_service.dart';
//
// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser;
//   PlatformFile? pickedFile;
//   UploadTask? uploadTask;
//
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result == null) return;
//     setState(() {
//       pickedFile = result.files.first;
//     });
//   }
//
//   Future uploadFile() async {
//     final path = 'assets/images/avatar/${pickedFile!.name}';
//     final file = File(pickedFile!.path!);
//     final ref = FirebaseStorage.instance.ref().child(path);
//     ref.putFile(file);
//     final snapshot = await uploadTask!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     print('Download Link: $urlDownload');
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Row(
//       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //     children: [
//       //       const Text("Welcome User"),
//       //    ),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (pickedFile != null)
//               Expanded(
//                 child: Container(
//                   color: Colors.blue[100],
//                   child: Image.file(
//                     File(pickedFile!.path!),
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             const SizedBox(
//               height: 10,
//             ),
//             MaterialButton(
//               padding: const EdgeInsets.all(10),
//               color: Colors.yellow,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5)),
//               onPressed: selectFile,
//               child: const Text(
//                 'Choose file..',
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ),
//             const SizedBox(
//               height: 32,
//             ),
//             MaterialButton(
//               padding: const EdgeInsets.all(10),
//               color: Colors.yellow,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5)),
//               onPressed: uploadFile,
//               child: const Text(
//                 'Upload',
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ),
//             Text(
//               FirebaseAuth.instance.currentUser!.displayName!,
//               style: const TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               FirebaseAuth.instance.currentUser!.email!,
//               style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             MaterialButton(
//               padding: const EdgeInsets.all(10),
//               color: Colors.yellow,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(5)),
//               child: const Text(
//                 'LOG OUT',
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//               onPressed: () {
//                 AuthService().signOut();
//               },
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite_border),
//             label: 'Saved',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add_outlined),
//             label: 'News',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart_outlined),
//             label: 'Product',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Account',
//           ),
//         ],
//         //currentIndex: _selectedIndex,
//         selectedItemColor: Colors.yellow,
//         unselectedItemColor: Colors.black,
//         //onTap: _onItemTapped,
//       ),
//     );
//   }
// }
