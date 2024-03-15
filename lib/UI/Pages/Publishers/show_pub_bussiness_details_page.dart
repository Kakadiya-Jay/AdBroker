import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/UI/Pages/Publishers/edit_pub_bussiness_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowPublisherBusinessDetails extends StatefulWidget {
  const ShowPublisherBusinessDetails({super.key});

  @override
  State<ShowPublisherBusinessDetails> createState() => _ShowPublisherBusinessDetailsState();
}

class _ShowPublisherBusinessDetailsState extends State<ShowPublisherBusinessDetails> {
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
        centerTitle: true,
        elevation: 2,
        title: Text(
          "Business Details",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Publishers")
              .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator(
                color: Theme.of(context).shadowColor,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CupertinoActivityIndicator(
                color: Theme.of(context).shadowColor,
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Platform Name",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  snapshot.data!.docs[0]["platform_name"],
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Platform URL",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  snapshot.data!.docs[0]["platform_url"],
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Monthly Traffic",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  snapshot.data!.docs[0]["monthly_traffic"],
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
                        builder: (context) => UpdatePubBusinessDetails(
                          platformName: snapshot.data!.docs[0]["platform_name"],
                          platformURL: snapshot.data!.docs[0]["platform_url"],
                          monthlyTraffic: snapshot.data!.docs[0]["monthly_traffic"],
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
              ],
            ).centered().p16();
          },
        ),
      ),
    );
  }
}
