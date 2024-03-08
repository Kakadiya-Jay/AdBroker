// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:ad_brokers/UI/Pages/Authentications/forget_password.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_signuppage.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubLoginPage extends StatefulWidget {
  final String? userRole;

  const PubLoginPage({super.key, this.userRole});

  @override
  State<PubLoginPage> createState() => _PubLoginPageState();
}

class _PubLoginPageState extends State<PubLoginPage> {
  final emailText = TextEditingController();
  final passwordText = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = false;
  AuthService authService = AuthService();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    _isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).shadowColor,
              ).scale(scaleValue: 2),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/Login.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ).centered(),
                    const SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.70,
                          width: MediaQuery.of(context).size.width,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                "Login As Publisher",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Your Email",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: emailText,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Email Can't be Empty!!";
                                  }
                                  if (!value.contains(RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                                    return "Email Format is invalid";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFE6E3E9),
                                  hintText: "helloNew77@gmail.com",
                                  prefixIcon: const Icon(CupertinoIcons.mail),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Password",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: passwordText,
                                keyboardType: TextInputType.text,
                                obscureText: !_isVisible,
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Password Can't be Empty!!";
                                  }
                                  if (value.length < 8) {
                                    return "Password contains At least 8 characters";
                                  }
                                  if (!value.contains(RegExp(r'[A-Z]'))) {
                                    return "One character should be Capital";
                                  }
                                  if (!value.contains(RegExp(r'[a-z]'))) {
                                    return "One character should be Lowercase";
                                  }
                                  if (!value.contains(RegExp(r'[0-9]'))) {
                                    return "One character should be Number";
                                  }
                                  if (!value.contains(
                                      RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
                                    return "One character should be Special Character";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFE6E3E9),
                                  hintText: "********",
                                  prefixIcon: const Icon(CupertinoIcons.lock),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isVisible = !_isVisible;
                                      });
                                    },
                                    icon: _isVisible
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      if (emailText.text.isEmpty) {
                                        UiHelper.customErrorSnackBar(
                                          context,
                                          "Enter your Email which is associated with our service",
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgetPasswordPage(
                                              userEmail:
                                                  emailText.text.toString(),
                                              userRole:
                                                  widget.userRole.toString(),
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text(
                                      "Forgot your password?",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                child: CupertinoButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      loginUser();
                                    }
                                  },
                                  color: const Color(0xFF163648),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don’t have an account?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const PubSignUpPage(
                                            userRole: "Publishers",
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Color(0xFF163648),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ).p16(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  loginUser() async {
    setState(() {
      isLoading = true;
    });
    await authService
        .loginWithEmailandPassword(
      emailText.text.trim().toString(),
      passwordText.text.trim().toString(),
      widget.userRole.toString(),
    )
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot = await DatabaseService(
          uid: FirebaseAuth.instance.currentUser!.uid,
          userRole: widget.userRole.toString(),
        ).gettingPublishersData(
          emailText.text.toString(),
        );

        await HelperFunctions.saveUserLoggedInStatus(true);
        await HelperFunctions.saveUserEmailSF(emailText.text.toString());
        await HelperFunctions.saveUserNameSF(snapshot.docs[0]["name"]);
        await HelperFunctions.saveUserContactSF(snapshot.docs[0]["contact"]);
        await HelperFunctions.saveUserRoleSF(snapshot.docs[0]["role"]);
        await HelperFunctions.saveUserImageURLSF(
            snapshot.docs[0]["profile_pic"]);

        Navigator.pushNamedAndRemoveUntil(
          context,
          "/pub/frontPage",
          (route) => false,
        );
      } else {
        setState(() {
          isLoading = false;
        });
        UiHelper.customErrorSnackBar(context, value.toString());
      }
    });
  }
}
