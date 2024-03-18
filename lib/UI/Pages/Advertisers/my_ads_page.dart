import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/Services/ads_service.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/ongoing_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/pending_ads_page.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/history_ads_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAdsPage extends StatefulWidget {
  const MyAdsPage({super.key});

  @override
  State<MyAdsPage> createState() => _MyAdsPageState();
}

class _MyAdsPageState extends State<MyAdsPage> {
  List<Advertisements> advertisements = [];
  final adService = AdService();
  final advertiserUid = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    getAdvertisements();
    super.initState();
  }

  //Get Advertisements
  Future<void> getAdvertisements() async {
    final adResponse =
        await adService.getAdvertisementOfPerticularAdvertiser(advertiserUid);
    setState(() {
      advertisements = adResponse!;
    });
    filterAllAds();
  }

  List<Advertisements> ongoingAdsList = [];
  List<Advertisements> pendingAdsList = [];
  List<Advertisements> historyAdsList = [];
  int index = 0;
  filterAllAds() {
    for (var item in advertisements) {
      if (advertisements[index].adStatus == "ongoing") {
        setState(() {
          ongoingAdsList.add(item);
        });
      } else if (advertisements[index].adStatus == "pending") {
        setState(() {
          pendingAdsList.add(item);
        });
      } else {
        setState(() {
          historyAdsList.add(item);
        });
      }
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          iconTheme: IconThemeData(
            color: Theme.of(context).shadowColor,
          ),
          title: Text(
            "Ads Page",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          elevation: 2.0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                context,
                "/adv/frontPage",
                (route) => false,
              );
              },
              icon: Icon(
                CupertinoIcons.refresh,
                color: Theme.of(context).shadowColor,
              ),
            )
          ],
          bottom: TabBar(
            tabs: [
              Text("Ongoing", style: Theme.of(context).textTheme.titleSmall)
                  .p(2),
              Text("Pending", style: Theme.of(context).textTheme.titleSmall)
                  .p(2),
              Text("History", style: Theme.of(context).textTheme.titleSmall)
                  .p(2),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OnGoingAdsPage(
              ongoingAds: ongoingAdsList,
            ),
            PendingAdsPage(
              pendingAds: pendingAdsList,
            ),
            HistoryAdsPage(
              historyAds: historyAdsList,
            ),
          ],
        ),
      ),
    );
  }
}
