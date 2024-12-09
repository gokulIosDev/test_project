import 'package:flutter/material.dart';

class UiHelper {
  static customTextField(TextEditingController controller,String hint,String labletext,IconData icon,){
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hint,
            labelText: labletext,
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            )
        ),
      ),
    );
  }
  static CustomSnackBar({required String text, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: const Color(0XFF1F41BB),
    ));
  }
  static  showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    Function()? onPressed,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // Allow dismissal by tapping outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Dismiss the alert
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed(); // Execute the callback function (if provided)
                }
              },
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}