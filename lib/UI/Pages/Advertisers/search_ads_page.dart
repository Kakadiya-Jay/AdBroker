import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/advertisement_model.dart';
import 'package:ad_brokers/UI/Widgets/my_ads_template_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final searchingText = TextEditingController();
  late List<Advertisements> filteredAds;

  getUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((value) {
      setState(() {
        brandName = value!;
      });
    });
  }

  void filterAdsByAdTitle(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredAds = widget.advertisements
            .where(
                (ad) => ad.adTitle.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredAds = widget.advertisements;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    filteredAds = widget.advertisements;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchingText.dispose();
    super.dispose();
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
              setState(() {
                filteredAds = widget.advertisements;
              });
            },
            icon: Icon(
              // CupertinoIcons.refresh,
              Icons.refresh,
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
                style: Theme.of(context).textTheme.displaySmall,
              ).pSymmetric(h: 16,v: 8),
              const SizedBox(height: 4,),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: searchingText,
                onChanged: (value) {
                  filterAdsByAdTitle(value);
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                  ).scale(scaleValue: 1.2),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchingText.clear();
                      setState(() {
                        filteredAds = widget.advertisements;
                      });
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                    ).scale(scaleValue: 1.2),
                  ),
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
              ).pSymmetric(h: 16),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemCount: filteredAds.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (filteredAds.isEmpty && filteredAds == []) {
                    return Center(
                      child: Text(
                        "No Data Available",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    );
                  }
                  var advertisement = filteredAds[index];
                  return MyAdsTemplate(
                    imagePath: advertisement.adImageUrl,
                    adTitle: advertisement.adTitle,
                    remainViews: advertisement.remainViews,
                    noOfPlatforms: 0,
                    adStatus: advertisement.adStatus,
                    noOfDaysLeft: 0,
                    adCategory: advertisement.adCategory,
                    brandName: brandName,
                    animationKey: advertisement.id,
                    price: "499",
                  );
                },
              ).pSymmetric(v: 8)
            ],
          ),
        ),
      ),
    );
  }
}
