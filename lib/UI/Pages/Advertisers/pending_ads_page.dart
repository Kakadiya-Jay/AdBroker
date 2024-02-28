// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/cupertino.dart';

class PendingAdsPage extends StatefulWidget {
  const PendingAdsPage({super.key});

  @override
  State<PendingAdsPage> createState() => _PendingAdsPageState();
}

class _PendingAdsPageState extends State<PendingAdsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const MyAdsTemplate(
          imagePath: "assets/images/Sample-Ad-Image-2.jpg",
          noOfDays: 0,
          noOfViwes: 0,
          noOfPlateforms: 0,
          adStatus: "pending",
        )
      ],
    );
  }
}
