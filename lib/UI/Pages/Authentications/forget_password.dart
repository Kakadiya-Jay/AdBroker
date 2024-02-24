import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ForgetPasswordPage extends StatefulWidget {
  final String userEmail;
  const ForgetPasswordPage({super.key, required this.userEmail});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 194, 194, 194),
                  prefixIcon: const Icon(CupertinoIcons.mail),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.white),
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
                  onPressed: () {},
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
}
