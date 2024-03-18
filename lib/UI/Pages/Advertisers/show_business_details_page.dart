import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/update_adv_business_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowBusinessDetailsPage extends StatefulWidget {
  const ShowBusinessDetailsPage({super.key});

  @override
  State<ShowBusinessDetailsPage> createState() =>
      _ShowBusinessDetailsPageState();
}

class _ShowBusinessDetailsPageState extends State<ShowBusinessDetailsPage> {
  String userEmail = "";
  String userRole = "";

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  loadUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((val) {
      setState(() {
        userEmail = val!;
      });
    });

    await HelperFunctions.getUserRoleFromSF().then((val) {
      setState(() {
        userRole = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Business Details",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Advertisers")
                .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (!snapshot.hasData) {
                return CupertinoActivityIndicator(
                  color: Theme.of(context).shadowColor,
                ).scale(scaleValue: 2.0);
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CupertinoActivityIndicator(
                  color: Theme.of(context).shadowColor,
                ).scale(scaleValue: 2.0);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BrandName",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.docs[0]["brand_name"],
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Brand URL",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.docs[0]["brand_url"],
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Brand Category",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.docs[0]["brand_category"],
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Brand Address",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.docs[0]["brand_address"],
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Brand Valuation",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.docs[0]["valuation"] ?? "",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateAdvBusinessDetailsPage(
                            uid: FirebaseAuth.instance.currentUser!.uid
                                .toString(),
                            brandName: snapshot.data!.docs[0]["brand_name"],
                            brandURL: snapshot.data!.docs[0]["brand_url"],
                            brandCategory: snapshot.data!.docs[0]
                                ["brand_category"],
                            brandAddress: snapshot.data!.docs[0]
                                ["brand_address"],
                            valuation: snapshot.data!.docs[0]["valuation"],
                          ),
                        ),
                      );
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
                    height: 30,
                  ),
                ],
              ).p16();
            },
          ),
        ),
      ),
    );
  }
}
