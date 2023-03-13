import 'package:flutter/material.dart';
import 'package:second_hand_app/services/notification_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);

    //notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      print('device token');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text('Flutter Notification'),
    ),);
  }
}
