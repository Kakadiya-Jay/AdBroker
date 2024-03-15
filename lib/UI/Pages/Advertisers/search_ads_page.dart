import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchAdsPage extends StatefulWidget {
  final List<Advertisements> advertisements;
  const SearchAdsPage({
    super.key,
    required this.advertisements,
  });

  @override
  State<SearchAdsPage> createState() => _SearchAdsPageState();
}

class _SearchAdsPageState extends State<SearchAdsPage> {
  String brandName = "";

  getUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((value) {
      setState(() {
        brandName = value!;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Ads",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2.0,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              CupertinoIcons.refresh,
              color: Theme.of(context).shadowColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Search ads by ads title",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                  ).scale(scaleValue: 1.2),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 194, 194, 194),
                  hintText: "Search Ads",
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Color(
                        0xFF4F5359,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: widget.advertisements.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (widget.advertisements.isEmpty &&
                      widget.advertisements == []) {
                    return Center(
                      child: Text(
                        "No Data Available",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  }
                  return MyAdsTemplate(
                    imagePath: widget.advertisements[index].adImageUrl,
                    adTitle: widget.advertisements[index].adTitle,
                    remainViwes: widget.advertisements[index].remainViews,
                    noOfPlateforms: 0,
                    adStatus: widget.advertisements[index].adStatus,
                    noOfDaysLeft: 0,
                    adCategory: widget.advertisements[index].adCategory,
                    brandName: brandName,
                    animationKey: widget.advertisements[index].id,
                    price: "499",
                  );
                },
              ).pSymmetric(v: 8)
            ],
          ).p8(),
        ),
      ),
    );
  }
}
