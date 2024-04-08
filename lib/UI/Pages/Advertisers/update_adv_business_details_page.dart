// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateAdvBusinessDetailsPage extends StatefulWidget {
  String uid;
  String brandName;
  String brandURL;
  String brandCategory;
  String brandAddress;
  String valuation;

  UpdateAdvBusinessDetailsPage({
    super.key,
    required this.uid,
    required this.brandName,
    required this.brandURL,
    required this.brandCategory,
    required this.brandAddress,
    required this.valuation,
  });

  @override
  State<UpdateAdvBusinessDetailsPage> createState() =>
      _UpdateAdvBusinessDetailsPageState();
}

class _UpdateAdvBusinessDetailsPageState
    extends State<UpdateAdvBusinessDetailsPage> {
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
                "Brand Name",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.brandName,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.brandName = value.trim();
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
                "Brand URL",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.brandURL,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.brandURL = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "www.AdBrokers.com",
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
                "Brand Category",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.brandCategory,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.brandCategory = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Advertising Network",
                  prefixIcon: Icon(
                    Icons.category_rounded,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Brand Address",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.brandAddress,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  setState(() {
                    widget.brandAddress = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Surat,Gujarat,India",
                  prefixIcon: Icon(
                    CupertinoIcons.location,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Valuation",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                initialValue: widget.valuation,
                style: Theme.of(context).textTheme.displaySmall,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    widget.valuation = value.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: "1000000",
                  prefixIcon: Icon(
                    CupertinoIcons.money_dollar,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  if (widget.brandName != "" &&
                      widget.brandURL != "" &&
                      widget.brandCategory != "" &&
                      widget.brandAddress != "" &&
                      widget.valuation != "0") {
                    updateAdvBusinessDetails();
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
          ).p16(),
        ),
      ),
    );
  }

  updateAdvBusinessDetails() async {
    UiHelper.customSnackBar(
        context, "Business Details will be updated\nWait a moment..");
    await DatabaseService(
      uid: FirebaseAuth.instance.currentUser!.uid.toString(),
    )
        .updateAdvertiserBusinessDetails(
      widget.brandName,
      widget.brandURL,
      widget.brandCategory,
      widget.brandAddress,
      widget.valuation,
    )
        .then(
      (value) async {
        if (value == true) {
          await HelperFunctions.saveAdvBrandNameSF(widget.brandName.toString());
          await HelperFunctions.saveAdvBrandURLSF(widget.brandURL.toString());
          UiHelper.customSnackBar(context, "Details updated successfully");
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
