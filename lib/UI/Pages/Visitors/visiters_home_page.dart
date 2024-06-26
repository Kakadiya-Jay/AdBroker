import 'package:ad_brokers/UI/Widgets/carousel_slider_template.dart';
import 'package:ad_brokers/UI/Widgets/login_model.dart';
import 'package:ad_brokers/UI/Widgets/sign_up_dialog.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class VisitorSideHomePage extends StatefulWidget {
  const VisitorSideHomePage({super.key});

  @override
  State<VisitorSideHomePage> createState() => _VisitorSideHomePageState();
}

class _VisitorSideHomePageState extends State<VisitorSideHomePage> {
  selectedItem(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.pushNamed(context, "/visitor/aboutUsPage");
        break;
      case 1:
        Navigator.pushNamed(context, "/visitor/contactUsPage");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFF3C096C),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "AdBroker",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.yellowAccent,
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            color: Theme.of(context).scaffoldBackgroundColor,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Text(
                  "About Us",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Contact Us",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
            ],
            onSelected: (item) => selectedItem(context, item),
          )
        ],
        elevation: 0.0,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              curve: Curves.easeIn,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  "AdBroker",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                accountEmail: Text(
                  "AdBroker@gmail.com",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                currentAccountPictureSize: const Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  child: Text(
                    "A",
                    style: Theme.of(context).textTheme.labelLarge,
                  ), //Text
                ), //circleA
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.info,
                color: Theme.of(context).shadowColor,
              ),
              title: Text(
                "About Us",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/visitor/aboutUsPage");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.connect_without_contact,
                color: Theme.of(context).shadowColor,
              ),
              title: Text(
                "Contact Us",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/visitor/contactUsPage");
              },
            ),
            ListTile(
              leading: Icon(
                Icons.follow_the_signs,
                color: Theme.of(context).shadowColor,
              ),
              title: Text(
                "Follow Us",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.doc_append,
                color: Theme.of(context).shadowColor,
              ),
              title: Text(
                "Documentation",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: const [
                  CarouselSliderItems(
                    imagePath: "assets/images/online_marketing.jpg",
                  ),
                  CarouselSliderItems(
                    imagePath: "assets/images/social_marketing.jpg",
                  ),
                  CarouselSliderItems(
                    imagePath: "assets/images/Advertising.jpg",
                  ),
                ],
                options: CarouselOptions(
                  // height: context.isMobile ? 200 : MediaQuery.of(context).size.height / 2,
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  viewportFraction: 0.8,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Advanced Advertising Network",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "With our advertising network, publishers maximize eCPM with relevant ad feed while advertisers meet their KPIs and enhance ROI. Grow your business with the best team in the industry!",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  color: Theme.of(context).cardColor,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          "Monetization section",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                fontSize: 22,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          CupertinoIcons.group_solid,
                          color: Theme.of(context).shadowColor,
                        ).scale(scaleValue: 1.2),
                        title: Text("Acquire More traffic",
                            style: Theme.of(context).textTheme.titleSmall),
                        subtitle: Text(
                          "Gain More traffics and publish your ad on various platforms",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onTap: () {
                          UiHelper.customSnackBar(context,
                              "Please Register with us As Advertiser..");
                        },
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.attach_money,
                          color: Theme.of(context).shadowColor,
                        ).scale(scaleValue: 1.2),
                        title: Text(
                          "Monetise traffic",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        subtitle: Text(
                          "Increase number of traffic on your application and earned more money",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onTap: () {
                          UiHelper.customSnackBar(context,
                              "Please Register with us As Publisher..");
                        },
                      )
                    ],
                  ).pSymmetric(h: 16, v: 8),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Roles",
                style: Theme.of(context).textTheme.titleLarge,
              ).px(8),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 8.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 3,
                        child: Image.asset(
                          "assets/images/User.png",
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ).p(8),
                      Text(
                        "Advertisers",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "Adsterra is a powerful online advertising network for brands, agencies, and media buyers. With over 20 targeting settings, you deliver ads to the best-matching audiences. Unlock high-quality CPM, CPC, and CPA traffic from 28K+ direct publishers.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ).pSymmetric(h: 16, v: 8),
                    ],
                  ),
                ).p8(),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 8.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 3,
                        child: Icon(
                          CupertinoIcons.globe,
                          size: 100,
                          color: Theme.of(context).shadowColor,
                        ),
                      ).p(8),
                      Text(
                        "Publisher",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        "With the highest-paying ad network, publishers can monetize sites, blogs or social media traffic. We provide solutions for earning without a website. AI algorithms are finetuned to send the most relevant CPM rates and ad feed.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ).pSymmetric(h: 16, v: 8),
                    ],
                  ),
                ).p8(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Note",
                style: Theme.of(context).textTheme.titleLarge,
              ).px8(),
              const SizedBox(
                height: 5,
              ),
              Card(
                color: Theme.of(context).cardColor,
                elevation: 8.0,
                child: Text(
                  "Our service provides \"Advertising Publishing Network\" so for user satisfaction purpose we provide 1 month free subscription facility for every role users.\n\nWe provide ₹499 free subscription for 1 month\n\nThis is valid on first registration.",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displaySmall,
                ).p16(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "For more info Register with us..",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.displayMedium,
              ).centered(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginModel(),
                  SignUpDialog(),
                ],
              ),
            ],
          ).p16(),
        ],
      ),
    );
  }
}
