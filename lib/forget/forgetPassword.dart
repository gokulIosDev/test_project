import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase/widgets/uihelper.dart';
import 'package:project/signIn/signInScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ForgetPassword"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          UiHelper.customTextField(
              emailController, "enter E-mail", "email", Icons.email),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                forget(email: emailController.text.toString());
              },
              child: Text("Send Mail"))
        ],
      ),
    );
  }

  forget({required String email}) async {
    if (email == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter Required Fields", context: context);
    } else {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        return UiHelper.CustomSnackBar(
            text: "Otp Sent to $email", context: context);
      });
    }
  }
}
