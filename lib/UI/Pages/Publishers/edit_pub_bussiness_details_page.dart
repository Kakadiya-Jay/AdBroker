// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdatePubBusinessDetails extends StatefulWidget {
  String platformName;
  String platformURL;
  String monthlyTraffic;

  UpdatePubBusinessDetails({
    super.key,
    required this.platformName,
    required this.platformURL,
    required this.monthlyTraffic,
  });

  @override
  State<UpdatePubBusinessDetails> createState() =>
      _UpdatePubBusinessDetailsState();
}

class _UpdatePubBusinessDetailsState extends State<UpdatePubBusinessDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Edit Details",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        elevation: 2.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Platform Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.platformName,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.platformName = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "AdBrokers",
                  prefixIcon: Icon(
                    CupertinoIcons.textformat_abc,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Platform URL",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.platformURL,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.platformURL = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "https://www.AdBrokers.com",
                  prefixIcon: Icon(
                    CupertinoIcons.link,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Monthly Traffic",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.monthlyTraffic,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.monthlyTraffic = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "10k-20k",
                  prefixIcon: Icon(
                    CupertinoIcons.group,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  if (widget.platformName != "" &&
                      widget.platformURL != "" &&
                      widget.monthlyTraffic != "") {
                    updatePubBusinessDetails();
                  } else {
                    UiHelper.customErrorSnackBar(
                      context,
                      "Please enter Required Fields",
                    );
                  }
                },
                color: const Color(0xffFFE501),
                child: const Text(
                  "Update Details",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF3C096C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ).centered(),
              const SizedBox(
                height: 20,
              ),
            ],
          ).p16().centered(),
        ),
      ),
    );
  }

  updatePubBusinessDetails() async {
    UiHelper.customSnackBar(
        context, "Business Details will be updated\nWait a moment..");
    await DatabaseService(
      uid: FirebaseAuth.instance.currentUser!.uid.toString(),
    )
        .updatePublisherBusinessDetails(
      widget.platformName,
      widget.platformURL,
      widget.monthlyTraffic,
    )
        .then(
      (value) async {
        if (value == true) {
          await HelperFunctions.saveAdvBrandNameSF(
              widget.platformName.toString());
          await HelperFunctions.saveAdvBrandURLSF(
              widget.platformURL.toString());
          UiHelper.customSnackBar(context, "Details updated successfully");
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
