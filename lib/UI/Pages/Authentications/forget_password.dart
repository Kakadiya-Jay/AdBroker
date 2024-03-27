import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/UI/Pages/Authentications/adv_loginpage.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_loginpage.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgetPasswordPage extends StatefulWidget {
  final String userEmail;
  final String userRole;

  const ForgetPasswordPage(
      {super.key, required this.userEmail, required this.userRole});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final authservice = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        title: Text(
          "Forgot Password",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Recover Password",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                initialValue: widget.userEmail,
                enabled: false,
                style: Theme.of(context).textTheme.displaySmall,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.mail,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 48,
                child: CupertinoButton(
                  onPressed: () {
                    sendEmail();
                  },
                  color: Colors.deepPurple,
                  child: const Text("Send Email"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Note:- Recovery password link is send to your email address which you enter above..",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ).p16(),
        ).centered(),
      ),
    );
  }

  sendEmail() async {
    await authservice.forgotPassword(widget.userEmail.toString()).then((value) {
      if (value == true) {
        UiHelper.customSnackBar(context,
            "Wait for a moment Password Recovery mail is Sending in a moment");
        widget.userRole.toString() == "Advertisers"
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvLoginPage(
                    userRole: "Advertisers",
                  ),
                ),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PubLoginPage(
                    userRole: "Publishers",
                  ),
                ),
              );
      } else {
        UiHelper.customErrorSnackBar(context, value.toString());
      }
    });
  }
}
