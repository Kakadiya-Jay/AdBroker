import 'package:flutter/material.dart';

class UiHelper {
  static customAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium!),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Ok",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static customSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        duration: const Duration(seconds: 1),
        elevation: 8.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }

  static customErrorSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.redAccent,
        elevation: 4.0,
        // backgroundColor: const Color.fromARGB(255, 242, 154, 154),
        //     elevation: 6.0,
      ),
    );
  }
}
