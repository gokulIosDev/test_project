import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase/widgets/uihelper.dart';
import 'package:project/signIn/signInScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.customTextField(
              emailController, "enter Email", "Email", Icons.email),
          SizedBox(
            height: 20,
          ),
          UiHelper.customTextField(
              passwordController, "enter Password", "Password", Icons.password),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                signUp(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString());
              },
              child: Text("SignUp")),
          ElevatedButton(
              onPressed: () {
                UiHelper.showAlertDialog(
                    context: context,
                    title: "title",
                    content: "content",
                    buttonText: "buttonText",onPressed: (){
                      print("dismiss");
                });
              },
              child: Text("dilogBox"))
        ],
      ),
    );
  }

  signUp({required String email, required String password}) async {
    if (email == "" || password == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter required Fields", context: context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((value) {
          log(value.user!.uid.toString());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(
            text: ex.code.toString(), context: context);
      }
    }
  }
}
