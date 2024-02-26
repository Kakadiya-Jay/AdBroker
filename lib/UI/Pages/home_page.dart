import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/UI/Widgets/ads_template_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "";
  String userRole = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
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
              color: Colors.yellowAccent),
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
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.asset(
                        "assets/images/Google.png",
                        fit: BoxFit.cover,
                        height: 41,
                        width: 41,
                      ),
                    ),
                    title: Text(
                      greetMessage,
                      style: const TextStyle(
                        color: Color(0xFFCDCED0),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text(
                      userName,
                      style: const TextStyle(
                        color: Color(0xFFECECED),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(
                      CupertinoIcons.right_chevron,
                      color: Colors.white,
                    ),
                  ),
                ).pSymmetric(h: 24, v: 6),
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
                    title: Text("Your Role is",
                        style: Theme.of(context).textTheme.labelSmall),
                    subtitle: Text(userRole,
                        style: Theme.of(context).textTheme.titleSmall),
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
                    Row(
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
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AdsTemplateCard(
                        imagePath: "assets/images/Sample-Ad-Image-1.jpg",
                        noOfDaysLeft: 21,
                        icon: Icons.visibility,
                        brandName: "ABCD Company",
                        adsStatus: "OnGoing",
                        noOfViews: 3500,
                        noOfPlatforms: 5,
                        price: 899,
                      ),
                      AdsTemplateCard(
                        imagePath: "assets/images/Sample-Ad-Image-2.jpg",
                        noOfDaysLeft: 0,
                        icon: Icons.visibility,
                        brandName: "Brand Factory",
                        adsStatus: "Pending",
                      ),
                      AdsTemplateCard(
                        imagePath: "assets/images/Sample-Ad-Image-3.jpg",
                        icon: Icons.visibility,
                        noOfDaysLeft: 84,
                        brandName: "Web Developers",
                        adsStatus: "Upcoming",
                        price: 3499,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 0.5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Apply For New Ad",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                CupertinoButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/addNewAdPage");
                  },
                  color: Colors.purple,
                  child: const Text("Click Here"),
                ).centered(),
                const SizedBox(
                  height: 20,
                ),
              ],
            ).pSymmetric(h: 24),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addNewAdPage");
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
