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

  static confirmationDialogBox(
      BuildContext context, String text, Function callBackFunction) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Are you sure",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          surfaceTintColor: Colors.blueGrey,
          shadowColor: Theme.of(context).canvasColor,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    callBackFunction();
                  },
                  child: const Text(
                    "yes",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "no",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).p16();
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
        duration: const Duration(milliseconds: 2000),
        elevation: 8.0,
        backgroundColor: Theme.of(context).canvasColor,
        showCloseIcon: true,
        closeIconColor: Theme.of(context).shadowColor,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static customErrorSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        showCloseIcon: true,
        duration: const Duration(milliseconds: 2000),
        backgroundColor: Colors.redAccent,
        elevation: 4.0,
        closeIconColor: Colors.white,
        dismissDirection: DismissDirection.up,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10,
        ),
        behavior: SnackBarBehavior.floating,
        // backgroundColor: const Color.fromARGB(255, 242, 154, 154),
        //     elevation: 6.0,
      ),
    );
  }

  static customSuccessAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: const Color.fromARGB(255, 225, 253, 194),
          title: const Text(
            "Suceeded",
            style: TextStyle(
              color: Color.fromARGB(255, 42, 129, 29),
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ).centered(),
          children: <Widget>[
            Image.asset(
              "assets/gif/success.gif",
              height: 100,
              width: 100,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 42, 129, 29),
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ).p8(),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 42, 129, 29),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ).p8(),
              ),
            ).p8(),
          ],
        ).centered().p16();
      },
    );
  }

  static customFailureAlertBox(BuildContext context, String text) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: const Color.fromARGB(255, 255, 203, 203),
          title: const Text(
            "Failure",
            style: TextStyle(
              color: Color.fromARGB(255, 165, 36, 36),
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ).centered(),
          children: <Widget>[
            Image.asset(
              "assets/gif/failure.gif",
              height: 100,
              width: 100,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 165, 36, 36),
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ).p8(),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 165, 36, 36),
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ).p8(),
              ),
            ).pSymmetric(h: 8),
          ],
        ).centered().p16();
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
            Column(
              children: [
                CupertinoActivityIndicator(
                  color: Theme.of(context).shadowColor,
                ).scale(scaleValue: 2.0).centered(),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ],
        ).p16().centered();
      },
    );
  }
}
