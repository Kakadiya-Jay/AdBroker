import 'package:ad_brokers/UI/Pages/Advertisers/ongoing_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/pending_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/upcoming_ads_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "Ads Page",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Text("Ongoing", style: Theme.of(context).textTheme.titleSmall)
                  .p(2),
              Text("Upcoming", style: Theme.of(context).textTheme.titleSmall)
                  .p(2),
              Text("Pending", style: Theme.of(context).textTheme.titleSmall)
                  .p(2),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OnGoingAdsPage(),
            UpComingAdsPage(),
            PendingAdsPage(),
          ],
        ),
      ),
    );
  }
}
