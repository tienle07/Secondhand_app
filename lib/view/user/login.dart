import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:second_hand_app/authentication/auth_service.dart';
import 'package:second_hand_app/utils/constant.dart';
import 'package:second_hand_app/view/user/forgotpass.dart';
import 'package:second_hand_app/view/user/signup.dart';

import 'package:second_hand_app/view/widget/rep_textfiled.dart';




class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(15),
          width: gWidth,
          height: gHeight,
          child: Column(
            children: const [
              TopImage(),
              LoginText(),
              SizedBox(height: 20),
              EmailTextFiled(),
              SizedBox(
                height: 20,
              ),
              PasswordTextFiled(),
              ForgotText(),
              SizedBox(
                height: 15,
              ),
              LoginButton(),
              SizedBox(height: 15),
              OrText(),
              SizedBox(height: 15),
              GoogleLoginButton(),
              RegisterText(),
            ],
          ),
        ),
      ),
    );
  }
}

// Register Text Components
class RegisterText extends StatelessWidget {
  const RegisterText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: GestureDetector(
        onTap: () {
          Get.offAll(
            () => const SignUpScreen(),
            transition: Transition.leftToRight,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 22),
          width: gWidth / 2,
          height: gHeight / 32,
          child: FittedBox(
            child: RichText(
              text: const TextSpan(
                text: "New to Logistic?",
                style: TextStyle(color: text1Color),
                children: [
                  TextSpan(
                    text: "  Register",
                    style: TextStyle(
                      color: buttonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Login With Google Button Components
class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            AuthService().signInWithGoogle();
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              buttonColor.withOpacity(0.2),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all(const Color.fromARGB(255, 238, 238, 238)),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: Image.network(
                    "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png"),
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                "Login with Google",
                style: TextStyle(color: Color.fromARGB(255, 90, 90, 90)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// OR Text Components
class OrText extends StatelessWidget {
  const OrText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 1000),
      child: SizedBox(
        width: gWidth,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130,
                height: 0.5,
                color: iconColor,
              ),
              const Text(
                "  OR  ",
                style: TextStyle(color: iconColor, fontSize: 20),
              ),
              Container(
                width: 130,
                height: 0.5,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Login Button Components
class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 1400),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: gWidth,
        height: gHeight / 15,
        child: ElevatedButton(
          onPressed: () {
            Get.offAll(const LoginScreen());
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(buttonColor),
          ),
          child: const Text("Login"),
        ),
      ),
    );
  }
}

// Forgot Text Components
class ForgotText extends StatelessWidget {
  const ForgotText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 1800),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => const ForgotPasswordScreen(),
            transition: Transition.leftToRight,
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 240, top: 20),
          width: gWidth / 3.7,
          height: gHeight / 32,
          child: const FittedBox(
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: buttonColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}

// Password TextFiled Components
class PasswordTextFiled extends StatelessWidget {
  const PasswordTextFiled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 2300),
      child: const RepTextFiled(
        sufIcon: Icon(LineIcons.eyeSlash),
        icon: LineIcons.alternateUnlock,
        text: "Password",
      ),
    );
  }
}

// Email TextFiled Components
class EmailTextFiled extends StatelessWidget {
  const EmailTextFiled({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 2900),
      child: RepTextFiled(
        sufIcon: null,
        icon: LineIcons.at,
        text: "Email ID",
      ),
    );
  }
}

// Top Login Text Components
class LoginText extends StatelessWidget {
  const LoginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: const Duration(milliseconds: 3200),
      child: Container(
        margin: EdgeInsets.only(right: 270, top: 10),
        width: gWidth / 4,
        height: gHeight / 18,
        child: const FittedBox(
          child: Text(
            "Login",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Top Image Components
class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 3800),
      child: SizedBox(
        width: gWidth,
        height: gHeight / 2.85,
        child: Image.asset(
          "assets/images/login.png",
        ),
      ),
    );
  }
}

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
