// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/contact_us_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubContactUsPage extends StatefulWidget {
  const PubContactUsPage({super.key});

  @override
  State<PubContactUsPage> createState() => _PubContactUsPageState();
}

class _PubContactUsPageState extends State<PubContactUsPage> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  final queryTitleText = TextEditingController();
  final queryDetailsText = TextEditingController();
  final userRole = "Publisher";

  String userEmail = "";
  String userPhone = "";

  final contactUsSercice = ContactUsService();

  @override
  void initState() {
    getUsersData();
    isLoading = false;
    super.initState();
  }

  getUsersData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        userEmail = value!;
      });
    });

    await HelperFunctions.getUserContactFromSF().then((value) {
      setState(() {
        userPhone = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        title: Text(
          "Contact Us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: isLoading
                ? Center(
                    child: CupertinoActivityIndicator(
                      color: Theme.of(context).shadowColor,
                    ).scale(scaleValue: 2.0),
                  )
                : Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Text(
                          "Your Role : $userRole",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: queryTitleText,
                          style: Theme.of(context).textTheme.displaySmall,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                            prefixIcon: Icon(
                              Icons.label,
                              color: Theme.of(context).shadowColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          style: Theme.of(context).textTheme.displaySmall,
                          decoration: InputDecoration(
                            labelText: userEmail,
                            prefixIcon: Icon(
                              CupertinoIcons.mail,
                              color: Theme.of(context).shadowColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          enabled: false,
                          style: Theme.of(context).textTheme.displaySmall,
                          decoration: InputDecoration(
                            labelText: userPhone,
                            prefixIcon: Icon(
                              CupertinoIcons.phone,
                              color: Theme.of(context).shadowColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: queryDetailsText,
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.displaySmall,
                          maxLines: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Write your query here...",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: CupertinoButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                sendQuery();
                              }
                            },
                            color: const Color(0xffFFE501),
                            child: const Text(
                              "Submit Query",
                              style: TextStyle(
                                color: Color(0xFF3C096C),
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ).p8(),
                  ),
          ),
        ),
      ),
    );
  }

  sendQuery() async {
    setState(() {
      isLoading = true;
    });

    await contactUsSercice
        .sendNewQueryOfUser(
      FirebaseAuth.instance.currentUser!.uid.toString(),
      userRole,
      userEmail,
      userPhone,
      queryTitleText.text.toString(),
      queryDetailsText.text.toString(),
    )
        .then((value) async {
      setState(() {
        isLoading = false;
      });
      if (value == true) {
        await UiHelper.customSuccessAlertBox(
          context,
          "Your Query has been sent successfully..\nWe will reply within a 24 hour",
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/pub/frontPage",
          (route) => false,
        );
      } else {
        UiHelper.customErrorSnackBar(
          context,
          "Something went wrong..\nPlease try again later",
        );
      }
    });
  }
}
