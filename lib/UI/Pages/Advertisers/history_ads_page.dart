// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HistoryAdsPage extends StatefulWidget {
  final List<Advertisements> historyAds;
  const HistoryAdsPage({
    super.key,
    required this.historyAds,
  });

  @override
  State<HistoryAdsPage> createState() => _HistoryAdsPageState();
}

class _HistoryAdsPageState extends State<HistoryAdsPage> {
  String brandName = "";
  String brandURL = "";

  getUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((value) {
      setState(() {
        brandName = value!;
      });
    });
    await HelperFunctions.getAdvBrandURLSF().then((value) {
      setState(() {
        brandURL = value!;
      });
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.historyAds.isEmpty) {
      return Center(
        child: Image.asset(
          "assets/images/No data-amico.png",
          height: 330,
          width: MediaQuery.of(context).size.width * 0.80,
          filterQuality: FilterQuality.high,
          fit: BoxFit.fill,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: widget.historyAds.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return MyAdsTemplate(
            imagePath: widget.historyAds[index].adImageUrl,
            adTitle: widget.historyAds[index].adTitle,
            remainViews: widget.historyAds[index].remainViews,
            noOfPlatforms: 0,
            adStatus: widget.historyAds[index].adStatus,
            adCategory: widget.historyAds[index].adCategory,
            adType: widget.historyAds[index].adType,
            brandName: brandName,
            brandURL: brandURL,
            animationKey: widget.historyAds[index].id,
            price: widget.historyAds[index].price,
          );
        },
      ).pSymmetric(v: 6);
    }
  }
}
