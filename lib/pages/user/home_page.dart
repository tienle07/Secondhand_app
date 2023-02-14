import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/login.dart';
import 'package:second_hand_app/pages/user/profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              else if(snapshot.hasData){
                return const LoginGoogle();
              }
              else if(snapshot.hasError){
                return const Center(child: Text('Something Went Wrong'));
              }
              else{
                return Login();
              }
            },
          ),
      );
}


