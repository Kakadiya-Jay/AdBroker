import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
        duration: const Duration(milliseconds: 1500),
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
        duration: const Duration(milliseconds: 1500),
        backgroundColor: Colors.redAccent,
        elevation: 4.0,
        // backgroundColor: const Color.fromARGB(255, 242, 154, 154),
        //     elevation: 6.0,
      ),
    );
  }

  static customSuccessAlertBox(
      BuildContext context, String successText, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(successText),
        );
      },
    );
  }

  static customWaitingModel(BuildContext context, String text) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return Wrap(
          children: [
            CupertinoActivityIndicator(
              color: Theme.of(context).shadowColor,
            ).scale(scaleValue: 2.0),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ).p16().centered();
      },
    );
  }
}
