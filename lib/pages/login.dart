import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:second_hand_app/authentication/auth_service.dart';
import 'package:second_hand_app/pages/signup.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16,right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Text("Welcome,",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                  SizedBox(height: 6,),
                  Text("Sign in to continue!",style: TextStyle(fontSize: 20,color: Colors.grey.shade400),),
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email ID",
                      labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 14,color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 12,),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text("Forgot Password ?",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xffff5f6d),
                              Color(0xffff5f6d),
                              Color(0xffffc371),
                            ],
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(maxWidth: double.infinity,minHeight: 50),
                          child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: SignInButton(
                      Buttons.Google,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16
                          )),
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () {
                        AuthService().signInWithGoogle();
                      },
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("I'm a new user.",style: TextStyle(fontWeight: FontWeight.bold),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignUpPage();
                        }));
                      },
                      child: Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   appBar: AppBar(
    //     title: const Text("Secondhand_App"),
    //     backgroundColor: Colors.yellow,
    //   ),
    //   body: Container(
    //     width: size.width,
    //     height: size.height,
    //     padding: EdgeInsets.only(
    //         left: 20,
    //         right: 20,
    //         top: size.height * 0.2,
    //         bottom: size.height * 0.5),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         const Text("Hello \n",
    //             style: TextStyle(
    //               fontSize: 30,
    //               color: Colors.yellow,
    //             )),
    //         SignInButton(
    //           Buttons.Google,
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(16
    //               )),
    //           padding: const EdgeInsets.all(8.0),
    //           onPressed: () {
    //             AuthService().signInWithGoogle();
    //           },
    //         ),
    //         // TextButton(
    //         //   onPressed: () {
    //         //     AuthService().signInWithGoogle();
    //         //   },
    //         //   child: Text('Login with Gooogle'),
    //         //   //child: const Image(width: 100, image: AssetImage('assets/google.png'))
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}


