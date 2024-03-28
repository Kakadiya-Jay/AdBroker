// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdvBusinessDetailsPage extends StatefulWidget {
  const AdvBusinessDetailsPage({super.key});

  @override
  State<AdvBusinessDetailsPage> createState() => _AdvBusinessDetailsPageState();
}

class _AdvBusinessDetailsPageState extends State<AdvBusinessDetailsPage> {
  final formkey = GlobalKey<FormState>();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final brandNameText = TextEditingController();
  final brandURLText = TextEditingController();
  final brandCategoryText = TextEditingController();
  final brandAddressText = TextEditingController();
  final brandValuationText = TextEditingController();

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
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Brand Name",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: brandNameText,
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
                        Text(
                          "Brand URL",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: brandURLText,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Url Can't be empty";
                            }
                            if (!value.contains(RegExp(
                                r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?"))) {
                              return "URL format is incorrect";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- www.AdBrokers.com",
                            prefixIcon: const Icon(CupertinoIcons.link),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Brand Category",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: brandCategoryText,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Please enter brand category";
                            }
                            if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                              return "Category should be in Alphanumeric form";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- Advertising Network",
                            prefixIcon: const Icon(Icons.category_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Brand Address",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: brandAddressText,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Please enter Address";
                            }
                            if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                              return "Address should be in Alphanumeric form";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- Surat,Gujarat,India",
                            prefixIcon: const Icon(CupertinoIcons.location),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Valuation",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: brandValuationText,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty && value == "") {
                              return "Please enter Valuation";
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return "Category should be in Numeric form";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Ex:- 12000",
                            prefixIcon:
                                const Icon(CupertinoIcons.number_circle),
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
                          height: 10,
                        ),
                      ],
                    ).p16(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  registerAdvertisersBusiness() async {
    await DatabaseService(
            uid: FirebaseAuth.instance.currentUser!.uid.toString())
        .updateAdvertiserBusinessDetails(
      brandNameText.text.toString(),
      brandURLText.text.toString(),
      brandCategoryText.text.toString(),
      brandAddressText.text.toString(),
      brandValuationText.text.toString(),
    )
        .then(
      (value) async {
        if (value == true) {
          await HelperFunctions.saveAdvBrandNameSF(
              brandNameText.text.toString());
          await HelperFunctions.saveAdvBrandURLSF(brandURLText.text.toString());
          Navigator.pushNamedAndRemoveUntil(
            context,
            "/adv/frontPage",
            (route) => false,
          );
        } else {
          UiHelper.customErrorSnackBar(context, value.toString());
        }
      },
    );
  }
}
