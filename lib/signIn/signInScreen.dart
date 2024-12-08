import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase/widgets/uihelper.dart';
import 'package:project/forget/forgetPassword.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In Screen"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordScreen()));
                    },
                    child: Text("Forget Password?")),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                signIn(
                    email: emailController.text.toString(),
                    password: passwordController.text.toString());
              },
              child: Text("SignIn")),
        ],
      ),
    );
  }

  signIn({required String email, required String password}) async {
    if (email == "" || password == "") {
      return UiHelper.CustomSnackBar(
          text: "Enter Required Field", context: context);
    } else {
      UserCredential? userCredential;
      try {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          return UiHelper.CustomSnackBar(
              text: value.user!.email.toString(), context: context);
        });
      } on FirebaseAuthException catch (ex) {
        return UiHelper.CustomSnackBar(
            text: ex.code.toString(), context: context);
      }
    }
  }
}
