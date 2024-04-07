// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubBusinessDetailsPage extends StatefulWidget {
  const PubBusinessDetailsPage({super.key});

  @override
  State<PubBusinessDetailsPage> createState() => _PubBusinessDetailsPageState();
}

class _PubBusinessDetailsPageState extends State<PubBusinessDetailsPage> {
  final formkey = GlobalKey<FormState>();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final platformNameText = TextEditingController();
  final platformURLText = TextEditingController();
  final monthlyTrafficText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "Business info",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Center(
                child: Text(
                  "Register your business",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.85,
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
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Platform Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: platformNameText,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Please enter brand name";
                            }
                            if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                              return "Name should be in Alphanumeric form";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- AdBrokers",
                            prefixIcon:
                                const Icon(CupertinoIcons.textformat_abc),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Platform URL",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: platformURLText,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Please enter brand url";
                            }
                            if (!value.contains(RegExp(
                                r"(https?|http)://([-A-Za-z0-9.]+)(/[-A-Za-z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Za-z0-9+&@#/%=~_|!:‌​,.;]*)?"))) {
                              return "URL format is incorrect";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- ww.AdBrokers.com",
                            prefixIcon: const Icon(CupertinoIcons.link),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Monthly Traffic",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: monthlyTrafficText,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Please enter brand name";
                            }
                            if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                              return "Name should be in Alphanumeric form";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- 12000",
                            prefixIcon: const Icon(CupertinoIcons.person_3),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55,
                          child: CupertinoButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                registerAdvertisersBusiness();
                              }
                            },
                            color: const Color(0xFF163648),
                            child: const Text(
                              "Register Business",
                              textAlign: TextAlign.center,
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

  registerAdvertisersBusiness() async {
    await DatabaseService(
            uid: FirebaseAuth.instance.currentUser!.uid.toString())
        .updatePublisherBusinessDetails(
      platformNameText.text.toString(),
      platformURLText.text.toString(),
      monthlyTrafficText.text.toString(),
    )
        .then(
      (value) async {
        if (value == true) {
          await HelperFunctions.saveAdvBrandNameSF(
              platformNameText.text.toString());
          await HelperFunctions.saveAdvBrandURLSF(
              platformURLText.text.toString());
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/pub/frontPage",
            (route) => false,
          );
        } else {
          UiHelper.customErrorSnackBar(context, value.toString());
        }
      },
    );
  }
}
