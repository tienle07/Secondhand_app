import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:second_hand_app/authentication/auth_service.dart';
import 'package:second_hand_app/bindings/bindings.dart';
import 'package:second_hand_app/home_screens.dart';
import 'package:second_hand_app/services/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
  print(message.notification!.body.toString());
  print(message.data.toString());

}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       themeMode: ThemeMode.system,
//       initialBinding: MyBindings(),
//       debugShowCheckedModeBanner: false,
//       home: AuthService().handleAuthState(),
//       // home: const HomeScreen(),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);

    //notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print('fcmToken');
      print(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      initialBinding: MyBindings(),
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuthState(),
      // home: const HomeScreen(),
    );
  }
}

