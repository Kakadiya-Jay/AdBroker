// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Shared/constant.dart';
import 'package:ad_brokers/UI/Widgets/ads_template_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class AdvHomePage extends StatefulWidget {
  const AdvHomePage({super.key});

  @override
  State<AdvHomePage> createState() => _AdvHomePageState();
}

class _AdvHomePageState extends State<AdvHomePage> {
  String userName = "";
  String userRole = "";
  String userImageUrl = "";
  String brandName = "";
  bool isImageLoaded = true;

  @override
  void initState() {
    super.initState();
    gettingUserData();
    loadImage();
    getAdvertisements();
  }

  gettingUserData() async {
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    await HelperFunctions.getUserRoleFromSF().then((val) {
      setState(() {
        userRole = val!;
      });
    });
    await HelperFunctions.getUserImageUrlSF().then((val) {
      setState(() {
        userImageUrl = val!;
      });
    });
    await HelperFunctions.getAdvBrandNameSF().then((val) {
      setState(() {
        brandName = val!;
      });
    });
  }

  String greetUser() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour >= 5 && hour < 12) {
      return 'Happy Morning';
    } else if (hour >= 12 && hour < 16) {
      return 'Happy Afternoon';
    } else if (hour >= 16 && hour < 22) {
      return 'Happy Evening';
    } else {
      return 'Sweet Dreams';
    }
  }

  loadImage() async {
    setState(() {
      isImageLoaded = false;
    });
    await Future.delayed(
      const Duration(seconds: 2),
      () => loadUserProfileImage(),
    );
    setState(() {
      isImageLoaded = true;
    });
  }

  Widget loadUserProfileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        userImageUrl,
        fit: BoxFit.fill,
        height: 41,
        width: 41,
        filterQuality: FilterQuality.high,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.grey[400],
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }

  //Loadind Advertisement Contants
  List? listResponse;

  Future getAdvertisements() async {
    final http.Response response = await http.post(
      Uri.parse(APIConstant.baseURL + APIConstant.getAdvertisementByIdEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'advertiserId': FirebaseAuth.instance.currentUser!.uid.toString(),
      }),
    );
    if (response.statusCode == 200) {
      setState(() {
        listResponse = json.decode(response.body);
        print(listResponse);
      });
    } else {
      throw Exception('Failed to Load');
    }
  }

  @override
  Widget build(BuildContext context) {
    String greetMessage = greetUser();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF3C096C),
        title: const Text(
          "AdBrokers",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.yellowAccent,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: Colors.white,
          ).scale(scaleValue: 1.2),
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 25,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF3C096C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF372F3E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/adv/profilePage");
                    },
                    leading: isImageLoaded != true
                        ? const CupertinoActivityIndicator(
                            color: Colors.grey,
                          )
                        : userImageUrl == ""
                            ? CircleAvatar(
                                backgroundColor: const Color(0xFFF9F9F9),
                                foregroundColor: const Color(0XFF3C096C),
                                child: Text(
                                  userName[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 41,
                                width: 41,
                                child: loadUserProfileImage(),
                              ),
                    title: Text(
                      greetMessage,
                      style: const TextStyle(
                        color: Color(0xFFCDCED0),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      userName,
                      style: const TextStyle(
                        color: Color(0xFFECECED),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.chevron_right,
                      color: Colors.white,
                    ),
                  ),
                ).pSymmetric(h: 20, v: 6),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Theme.of(context).cardColor,
                  elevation: 4.0,
                  child: ListTile(
                    leading: ImageIcon(
                      const AssetImage("assets/icons/user_role.png"),
                      color: Theme.of(context).shadowColor,
                    ).scale(scaleValue: 1.5),
                    title: Text(
                      "Your Role is",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    subtitle: Text(
                      userRole,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Your Ads",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/adv/myAdsPage");
                      },
                      child: Row(
                        children: [
                          const Text(
                            "View All",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xFFFFC228),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.arrow_right,
                            color: Color(0xFFFFC228),
                          ).scale(scaleValue: 0.8)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 320,
                  child: listResponse == null
                      ? Center(
                          child: CupertinoActivityIndicator(
                            color: Theme.of(context).shadowColor,
                          ).scale(scaleValue: 2),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: listResponse?.length,
                          itemBuilder: (context, index) {
                            return AdsTemplateCard(
                              imagePath: listResponse![index]["image"],
                              brandName: brandName,
                              adsStatus: listResponse![index]["status"],
                              adTitle: listResponse![index]["title"],
                              adCategory: listResponse![index]["category"],
                              price: "499",
                              remainViews: listResponse![index]["remain_Views"],
                              animationKey: listResponse![index]["_id"],
                            );
                          },
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ).pSymmetric(h: 16),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/adv/addNewAdPage");
        },
        backgroundColor: const Color(0xFF50227B),
        elevation: 0.0,
        tooltip: "Add new Advertisement",
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
