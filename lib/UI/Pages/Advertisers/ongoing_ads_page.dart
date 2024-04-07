// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class OnGoingAdsPage extends StatefulWidget {
  final List<Advertisements> ongoingAds;
  const OnGoingAdsPage({
    super.key,
    required this.ongoingAds,
  });

  @override
  State<OnGoingAdsPage> createState() => _OnGoingAdsPageState();
}

class _OnGoingAdsPageState extends State<OnGoingAdsPage> {
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
    if (widget.ongoingAds.isEmpty) {
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
        itemCount: widget.ongoingAds.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return MyAdsTemplate(
            imagePath: widget.ongoingAds[index].adImageUrl,
            adTitle: widget.ongoingAds[index].adTitle,
            remainViews: widget.ongoingAds[index].remainViews,
            noOfPlatforms: 0,
            adStatus: widget.ongoingAds[index].adStatus,
            adCategory: widget.ongoingAds[index].adCategory,
            adType: widget.ongoingAds[index].adType,
            brandName: brandName,
            brandURL: brandURL,
            animationKey: widget.ongoingAds[index].id,
            price: widget.ongoingAds[index].price,
          );
        },
      ).pSymmetric(v: 6);
    }
  }
}
