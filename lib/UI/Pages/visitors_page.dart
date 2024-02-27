import 'package:ad_brokers/UI/Widgets/carousel_slider_template.dart';
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
  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
            color: Colors.white,
          ).scale(scaleValue: 1.2),
        ],
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Monitization section",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.group_solid,
                            color: Colors.grey)
                        .scale(scaleValue: 1.2),
                    title: Text("Aquire More traffic",
                        style: Theme.of(context).textTheme.titleSmall),
                    subtitle: Text(
                      "Gain More traffics and publish your ad on various platforms",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    onTap: () {
                      UiHelper.customSnackBar(
                          context, "Please Ragister with us As Advertiser..");
                    },
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.attach_money,
                      color: Colors.grey,
                    ).scale(scaleValue: 1.2),
                    title: Text(
                      "Monitise traffic",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      "Increse number of traffic on your application and earned more money",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    onTap: () {
                      UiHelper.customSnackBar(
                          context, "Please Ragister with us As Publisher..");
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
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Card(
            color: Colors.grey,
            elevation: 2.0,
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
                    ),
                  ).p(8),
                  Text(
                    "Advertisers",
                    style: Theme.of(context).textTheme.displaySmall,
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
            color: Colors.grey,
            elevation: 2.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 3,
                    child: const Icon(
                      CupertinoIcons.globe,
                      size: 100,
                    ),
                  ).p(8),
                  Text(
                    "Publisher",
                    style: Theme.of(context).textTheme.displaySmall,
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
            height: 10,
          ),
          const Divider(
            thickness: 0.1,
            height: 1,
          ),
          Text(
            "For more info Ragister with us..",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.displayMedium,
          ).centered(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LoginModel(),
              
              // SignUpDialoge(),
            ],
          ),
        ],
      ).p8(),
    );
  }
}
