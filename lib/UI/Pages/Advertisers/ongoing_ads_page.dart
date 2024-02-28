// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnGoingAdsPage extends StatefulWidget {
  const OnGoingAdsPage({super.key});

  @override
  State<OnGoingAdsPage> createState() => _OnGoingAdsPageState();
}

class _OnGoingAdsPageState extends State<OnGoingAdsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const MyAdsTemplate(
          imagePath: "assets/images/Sample-Ad-Image-1.jpg",
          noOfDays: 21,
          noOfViwes: 3500,
          noOfPlateforms: 5,
          adStatus: "ongoing",
        ),
      ],
    );
  }
}
