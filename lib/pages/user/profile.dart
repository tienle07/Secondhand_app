import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand_app/pages/user/google_sign_in.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            'User ID: $uid',
            style: const TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                'Email: $email',
                style: const TextStyle(fontSize: 18.0),
              ),
              user!.emailVerified
                  ? const
              Text(
                'Verified',
                style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
              )
                  : TextButton(
                  onPressed: () => {verifyEmail()},
                  child: const Text('Verify Email'))
            ],
          ),
          Text(
            'Created: $creationTime',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}

class LoginGoogle extends StatelessWidget {
  const LoginGoogle({super.key});

  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
          title: Text('Logged In'),
          centerTitle: true,
          actions: [
          TextButton(
      child: const Text('Logout',
        style: TextStyle(
            color: Colors.white),
      ),
      onPressed: () {
            final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
               }
          )
        ],
    ),

      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Profile',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 32),
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              const SizedBox(height: 8),
              Text(
                'Name: ' + user.displayName!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: ' + user.email!,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ]
        ),
      ),
    );
  }
}


