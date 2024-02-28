// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/UI/Pages/Authentications/forget_password.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdvLoginPage extends StatefulWidget {
  const AdvLoginPage({super.key});

  @override
  State<AdvLoginPage> createState() => _AdvLoginPageState();
}

class _AdvLoginPageState extends State<AdvLoginPage> {
  var emailText = TextEditingController();
  var passwordText = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  late bool _isVisible;
  AuthService authService = AuthService();
  bool isLoading = false;
  @override
  void initState() {
    _isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Wel-Come Back!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Center(
                      child: Text(
                        "Log in to your Account",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  "Login",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Your Email",
                                  textAlign: TextAlign.left,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                                      return "Email Format is invailed";
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
                                      return "Password contains Atleast 8 characters";
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
                                              builder: (contaxt) =>
                                                  ForgetPasswordPage(
                                                userEmail:
                                                    emailText.text.toString(),
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
                                      if (_formkey.currentState!.validate()) {
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                        Navigator.pushNamed(
                                            context, "/adv/signupPage");
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
                            ),
                          ),
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
            emailText.text.toString(), passwordText.text.toString())
        .then((value) async {
      if (value != null) {
        await HelperFunctions.saveUserLoggedInStatus(true);
        await HelperFunctions.saveUserEmailSF(emailText.text.toString());
        await HelperFunctions.saveUserNameSF(value["name"].toString());
        await HelperFunctions.saveUserContactSF(value["contactNo"].toString());
        await HelperFunctions.saveUserRoleSF(value["role"].toString());

        Navigator.pushNamedAndRemoveUntil(
            context, "/adv/frontPage", (route) => false);
      } else {
        setState(() {
          isLoading = false;
        });
        UiHelper.customErrorSnackBar(context, value.toString());
        setState(() {
          isLoading = false;
        });
      }
    });
  }
}