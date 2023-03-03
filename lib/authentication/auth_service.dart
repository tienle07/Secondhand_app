import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:second_hand_app/user/user_main.dart';
import 'package:second_hand_app/user/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthService {

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("tokenUS: ${googleAuth.idToken}");
    createProfile();
    // Once signed in, return the UserCredential

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> saveAccessToken(String token,String refreshToken) async {
    // Save the token to storage using your preferred storage mechanism
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<String?> getAccessToken() async {
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return googleAuth.idToken;
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // return prefs.getString('access_token');

  }
  Future<Map<String, String>> readTokens() async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString('access_token') ?? '';
    final refreshToken = prefs.getString('refresh_token') ?? '';

    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const UserMain();
          } else {
            return const LoginScreen();
          }
        });
  }


  //Sign out
  signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<String> createProfile() async {
    final String? idToken = await getAccessToken();
    if (idToken != null) {
      final response = await http.post(
        Uri.parse('http://s2tek.net:7100/swagger/index.html?fbclid=IwAR2Ynh0yEfhgmyyWwT17NvMlLs37zXkH2CwYv-X7aStZLMQVTORAmVrAEgA'),
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );

      if (response.statusCode == 200) {
        print('User authenticated on server.');
        return response.body;
      } else {
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Access token not found');
    }
  }
}