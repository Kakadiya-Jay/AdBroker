// ignore_for_file: use_build_context_synchronously

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/publisher_platforms_model.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/Services/publisher_platform_service.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_profile_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/pub_register_platform_page.dart';
import 'package:ad_brokers/UI/Pages/Publishers/show_pub_platform_details.dart';
import 'package:ad_brokers/UI/Widgets/show_platfrom_template_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubHomePage extends StatefulWidget {
  const PubHomePage({super.key});

  @override
  State<PubHomePage> createState() => _PubHomePageState();
}

class _PubHomePageState extends State<PubHomePage> {
  String userName = "";
  String userRole = "";
  String userImageUrl = "";
  final authService = AuthService();
  final platformService = PublisherPlatformService();

  bool isImageLoaded = false;

  @override
  void initState() {
    gettingUserData();
    loadImage();
    gettingPlatforms();
    super.initState();
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
      const Duration(seconds: 1),
      () => loadUserProfileImage(),
    );
    setState(() {
      isImageLoaded = true;
    });
  }

  List<PlatformModel> platforms = [];
  String pubId = FirebaseAuth.instance.currentUser!.uid.toString();

  Future<List<PlatformModel>> gettingPlatforms() async {
    try {
      final platformResponse =
          await platformService.getAllPublisherPlatform(pubId);
      platforms = platformResponse!;
      return platforms;
    } catch (e) {
      debugPrint(e.toString());
      // UiHelper.customErrorSnackBar(context, "Something went wrong..");
      return [];
    }
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
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                "/pub/frontPage",
                (route) => false,
              );
            },
            icon: const Icon(Icons.refresh),
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
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => const PubProfilePage(),
                        ),
                      );
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
                      maxLines: 1,
                      style: const TextStyle(
                        color: Color(0xFFECECED),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.right_chevron,
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
                // const SizedBox(
                //   height: 20,
                // ),
                // Card(
                //   elevation: 4.0,
                //   shadowColor: Theme.of(context).shadowColor,
                //   child: SizedBox(
                //     width: MediaQuery.of(context).size.width,
                //     height: 200,
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(16),
                //       child: Image.asset(
                //         "assets/images/subscription-banner-with-contant.png",
                //         fit: BoxFit.fill,
                //         filterQuality: FilterQuality.high,
                //       ),
                //     ),
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Your Platforms",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const RegisterPlatformPage(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Text(
                            "New Platform",
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
                  height: 10,
                ),
                SizedBox(
                  height: 245,
                  child: FutureBuilder<List<PlatformModel>>(
                    future: gettingPlatforms(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: Theme.of(context).shadowColor,
                          ),
                        ).scale(scaleValue: 2.0);
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}\nOr else please check your internet connection',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        );
                      } else {
                        if (snapshot.data!.isEmpty) {
                          return SizedBox(
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              elevation: 4.0,
                              color: Theme.of(context).cardColor,
                              child: Center(
                                child: Text(
                                  "No data available..",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount: platforms.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ShowPlatformTemplateCard(
                                id: platforms[index].id,
                                imagePath: "",
                                appName: platforms[index].name,
                                bundleId: platforms[index].bundleId,
                                appCategory: platforms[index].category,
                                redirectUrl: platforms[index].redirectURL,
                                totalViews: platforms[index].totalViews,
                                totalClicks: platforms[index].totalClicks,
                                totalEarning: platforms[index].totalEarnings,
                                onClickAction: () {
                                  List<PlatformModel> sharedPlatform = [];
                                  sharedPlatform.add(platforms[index]);
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (context) =>
                                          ShowPubPlatformDetails(
                                        platforms: sharedPlatform,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      }
                    },
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // // Row(
                //   children: [
                //     Text(
                //       "Running Ads",
                //       style: Theme.of(context).textTheme.displayMedium,
                //     ),
                //     const Spacer(),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Row(
                //         children: [
                //           const Text(
                //             "View All",
                //             textAlign: TextAlign.right,
                //             style: TextStyle(
                //               color: Color(0xFFFFC228),
                //               fontSize: 14,
                //               fontFamily: 'Poppins',
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //           const Icon(
                //             CupertinoIcons.arrow_right,
                //             color: Color(0xFFFFC228),
                //           ).scale(scaleValue: 0.8)
                //         ],
                //       ),
                //     )
                //   ],
                // ),
                // const SizedBox(
                //   height: 20,
                // ),
                // const SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       RunningAdsTemplateCard(
                //         imagePath: "assets/images/Sample-Ad-Image-1.jpg",
                //         brandName: "ABCD Company",
                //         noOfViews: 12000,
                //         adsCategory: "Product Sale",
                //         totalClicks: 100,
                //         profitAmount: 320,
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ).pSymmetric(h: 16),
          ],
        ),
      ),
    );
  }
}
