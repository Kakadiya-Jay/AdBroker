import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/publisher_platforms_model.dart';
import 'package:ad_brokers/Services/publisher_platform_service.dart';
import 'package:ad_brokers/UI/Pages/Publishers/show_pub_platform_details.dart';
import 'package:ad_brokers/UI/Widgets/filterd_platforms_template.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubAllPlatformPage extends StatefulWidget {
  const PubAllPlatformPage({super.key});

  @override
  State<PubAllPlatformPage> createState() => _PubAllPlatformPageState();
}

class _PubAllPlatformPageState extends State<PubAllPlatformPage> {
  String brandName = "";
  final searchingText = TextEditingController();
  final platformService = PublisherPlatformService();
  List<PlatformModel> platforms = [];
  List<PlatformModel> filterPlatform = [];
  String pubId = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  void initState() {
    gettingUsersData();
    gettingPlatforms();
    super.initState();
  }

  gettingUsersData() async {
    await HelperFunctions.getAdvBrandNameSF().then((val) {
      setState(() {
        brandName = val!;
      });
    });
  }

  gettingPlatforms() async {
    try {
      final platformResponse =
          await platformService.getAllPublisherPlatform(pubId);
      platforms = platformResponse!;
      setState(() {
        filterPlatform = platforms;
      });
    } catch (e) {
      debugPrint("Error :- ${e.toString()}");
    }
  }

  void filterPlatformByAdName(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filterPlatform = platforms
            .where((ad) => ad.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filterPlatform = platforms;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        elevation: 2.0,
        title: Text(
          brandName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
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
              ).pSymmetric(h: 16, v: 8),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: searchingText,
                style: Theme.of(context).textTheme.displaySmall,
                onChanged: (value) {
                  filterPlatformByAdName(value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: Theme.of(context).shadowColor,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchingText.clear();
                      setState(() {
                        filterPlatform = platforms;
                      });
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                  hintText: "Search Ads",
                ),
              ).pSymmetric(h: 16),
              const SizedBox(
                height: 10,
              ),
              filterPlatform.isEmpty
                  ? Center(
                      child: Image.asset(
                        "assets/images/No data-amico.png",
                        height: 330,
                        width: MediaQuery.of(context).size.width * 0.80,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fill,
                      ),
                    )
                  : ListView.builder(
                      itemCount: filterPlatform.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var advertisement = filterPlatform[index];
                        return FilterdPlatformTemplate(
                          id: advertisement.id,
                          imagePath: "",
                          appName: advertisement.name,
                          bundleId: advertisement.bundleId,
                          appCategory: advertisement.category,
                          redirectUrl: advertisement.redirectURL,
                          totalViews: advertisement.totalViews,
                          totalClicks: advertisement.totalClicks,
                          totalEarning: advertisement.totalEarnings,
                          onClickAction: () {
                            List<PlatformModel> sharedPlatform = [];
                            sharedPlatform.add(platforms[index]);
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ShowPubPlatformDetails(
                                  platforms: sharedPlatform,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ).pSymmetric(v: 8),
            ],
          ),
        ),
      ),
    );
  }
}
