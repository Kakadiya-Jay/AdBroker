import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/publisher_platforms_model.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowPubPlatformDetails extends StatefulWidget {
  final List<PlatformModel> platforms;
  const ShowPubPlatformDetails({
    super.key,
    required this.platforms,
  });

  @override
  State<ShowPubPlatformDetails> createState() => _ShowPubPlatformDetailsState();
}

class _ShowPubPlatformDetailsState extends State<ShowPubPlatformDetails> {
  String brandName = "";

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((value) {
      setState(() {
        brandName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4.0,
        iconTheme: IconThemeData(color: Theme.of(context).shadowColor),
        title: Text(
          brandName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: widget.platforms.isEmpty
          ? Card(
              color: Theme.of(context).cardColor,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "No Data Available..",
                  style: Theme.of(context).textTheme.displayMedium,
                ).centered(),
              ).p16().centered(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/icons/default-app-icon.png",
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ).centered(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.platforms[0].name,
                      style: Theme.of(context).textTheme.displayMedium,
                    ).centered(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Api Key :-",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(
                          ClipboardData(text: widget.platforms[0].id),
                        );
                        UiHelper.customSnackBar(
                          context,
                          "Api Key Copied Successfully",
                        );
                      },
                      child: Card(
                        color: Theme.of(context).cardColor,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: SizedBox(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            widget.platforms[0].id,
                            style: Theme.of(context).textTheme.displayMedium,
                          ).centered(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "You can copy id by long pressing on the above box",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ).centered(),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Theme.of(context).shadowColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Bundle Id :-",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.platforms[0].bundleId,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Category :-",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.platforms[0].category,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Redirect URL :-",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.platforms[0].redirectURL,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Earnings",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.platforms[0].totalClicks.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "Total clicks",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          "X",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              widget.platforms[0].totalViews.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              "Total views",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ).pSymmetric(h: 8),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "----------------",
                      style: Theme.of(context).textTheme.displaySmall,
                    ).centered(),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "${widget.platforms[0].totalEarnings}₹",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Total Earning",
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(color: Colors.green),
                        ),
                      ],
                    ).centered(),
                    const SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      onPressed: () {
                        UiHelper.customSnackBar(
                          context,
                          "Analsis page is in development\nWe'll notify soon..",
                        );
                      },
                      color: const Color(0xffFFE501),
                      child: const Text(
                        "View Analysis",
                        style: TextStyle(
                          color: Color(0xFF3C096C),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ).centered(),
                  ],
                ).p16(),
              ),
            ),
    );
  }
}
