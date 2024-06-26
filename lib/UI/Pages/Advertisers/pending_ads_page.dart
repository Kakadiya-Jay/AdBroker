// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PendingAdsPage extends StatefulWidget {
  final List<Advertisements> pendingAds;
  const PendingAdsPage({
    super.key,
    required this.pendingAds,
  });

  @override
  State<PendingAdsPage> createState() => _PendingAdsPageState();
}

class _PendingAdsPageState extends State<PendingAdsPage> {
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
    if (widget.pendingAds.isEmpty) {
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
        itemCount: widget.pendingAds.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return MyAdsTemplate(
            imagePath: widget.pendingAds[index].adImageUrl,
            adTitle: widget.pendingAds[index].adTitle,
            remainViews: widget.pendingAds[index].remainViews,
            noOfPlatforms: 0,
            adStatus: widget.pendingAds[index].adStatus,
            adCategory: widget.pendingAds[index].adCategory,
            adType: widget.pendingAds[index].adType,
            brandName: brandName,
            brandURL: brandURL,
            animationKey: widget.pendingAds[index].id,
            price: widget.pendingAds[index].price,
          );
        },
      ).pSymmetric(v: 6);
    }
  }
}
