import 'package:flutter/material.dart';

class UIhelper {
  static void showloadingDialog(
    BuildContext context,
    String title,
    // String text,
  ) {
    AlertDialog loadingDialog = AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.pink[200],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              title,
            ),
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      // barrierColor: Colors.red,
      // barrierLabel: text,
      builder: (context) {
        return loadingDialog;
      },
    );
  }

  static void showAlertDialog(
    BuildContext context,
    String title,
    String content,
  ) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Ok"))
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
