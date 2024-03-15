// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/cupertino.dart';

class HistoryAdsPage extends StatefulWidget {
  const HistoryAdsPage({super.key});

  @override
  State<HistoryAdsPage> createState() => _HistoryAdsPageState();
}

class _HistoryAdsPageState extends State<HistoryAdsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        const MyAdsTemplate(
          imagePath: "assets/images/Sample-Ad-Image-3.jpg",
          noOfDays: 0,
          noOfViwes: 0,
          noOfPlateforms: 0,
          adStatus: "upcoming",
        )
      ],
    );
  }
}
