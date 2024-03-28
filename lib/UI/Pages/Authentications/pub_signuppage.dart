// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/UI/Pages/Authentications/pub_loginpage.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubSignUpPage extends StatefulWidget {
  final String? userRole;

  const PubSignUpPage({super.key, this.userRole});

  @override
  State<PubSignUpPage> createState() => _PubSignUpPageState();
}

class _PubSignUpPageState extends State<PubSignUpPage> {
  var nameText = TextEditingController();
  var emailText = TextEditingController();
  var phoneText = TextEditingController();
  var passwordText = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isVisible = false;
  bool _isLoading = false;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    _isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _isLoading
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
                      "assets/images/SignUp.png",
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.87,
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
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 11,
                              ),
                              const Text(
                                "Register As Publisher",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xff19404D,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Full Name",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xff19404D,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: nameText,
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Name Can't be Empty!!";
                                  }
                                  if (!value
                                      .contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                                    return "Name should be in Alphanumeric form";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFE6E3E9),
                                  hintText: "Tony Howard Stark",
                                  prefixIcon: const Icon(CupertinoIcons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Email Address",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xff19404D,
                                  ),
                                ),
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
                                  hintText: "tonystark3000@gmail.com",
                                  prefixIcon: const Icon(CupertinoIcons.mail),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Phone",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xff19404D,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: phoneText,
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                validator: (value) {
                                  if (value!.isEmpty || value == "") {
                                    return "Phone number Can't be Empty!!";
                                  }
                                  if (value.length < 10) {
                                    return "Phone number should be have 10 numbers";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFE6E3E9),
                                  hintText: "9978******",
                                  prefixIcon: const Icon(CupertinoIcons.phone),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const Text(
                                "Password",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xff19404D,
                                  ),
                                ),
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
                              const SizedBox(
                                height: 25,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55,
                                child: CupertinoButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      signUpUser();
                                    }
                                  },
                                  color: const Color(0xFF163648),
                                  child: const Text(
                                    "Create Account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PubLoginPage(
                                            userRole: "Publishers",
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Color(0xFF163648),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

  signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    await _auth
        .registerWithEmailandPassword(
      nameText.text.trim().toString(),
      emailText.text.trim().toString(),
      phoneText.text.trim().toString(),
      widget.userRole.toString(),
      passwordText.text.trim().toString(),
    )
        .then((value) async {
      if (value == true) {
        //saving data into the shared preferences
        await HelperFunctions.saveUserLoggedInStatus(true);
        await HelperFunctions.saveUserNameSF(nameText.text.toString());
        await HelperFunctions.saveUserEmailSF(emailText.text.toString());
        await HelperFunctions.saveUserContactSF(phoneText.text.toString());
        await HelperFunctions.saveUserRoleSF(widget.userRole.toString());
        await HelperFunctions.saveUserImageURLSF("");
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/pub/registerBusinessPage",
          (route) => false,
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        UiHelper.customErrorSnackBar(
          context,
          value.toString(),
        );
      }
    });
  }
}
