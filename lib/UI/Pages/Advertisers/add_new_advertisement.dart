// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/subscription_model.dart';
import 'package:ad_brokers/Services/ads_service.dart';
import 'package:ad_brokers/Services/subscription_service.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_payment_service_page.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewAdvertisement extends StatefulWidget {
  const AddNewAdvertisement({super.key});

  @override
  State<AddNewAdvertisement> createState() => _AddNewAdvertisementState();
}

class _AddNewAdvertisementState extends State<AddNewAdvertisement> {
  String brandName = "";
  String brandURL = "";
  final formkey = GlobalKey<FormState>();
  final advId = FirebaseAuth.instance.currentUser!.uid;
  final adTitle = TextEditingController();
  String adCategory = "Choose an Ad Category";
  String adType = "Choose an Ad Type";
  XFile? image;
  String imagePath = "";
  final _subsriptionservice = SubscriptionService();
  List<SubscriptionModel> subscriptions = [];
  String planName = "";
  num planPrice = 0;
  num noOfViews = 0;
  var adService = AdService();

  getAllActiveSubscriptions() async {
    final response = await _subsriptionservice.getAllSubscriptions();
    setState(() {
      subscriptions = response!;
      planName = subscriptions[0].planName;
      planPrice = subscriptions[0].planPrice;
      noOfViews = subscriptions[0].noOfViews;
    });
  }

  var adCategoryList = [
    "Choose an Ad Category",
    "Gaming",
    "Entertainements",
    "Movie",
    "OTT",
    "Cinema",
    "Education",
    "Institute",
    "Product",
    "Tech Products",
    "Gadgets",
    "E-commerce",
    "Loan",
    "Finance",
    "Custom"
  ];
  var adTypes = [
    "Choose an Ad Type",
    "Interstitial",
    "Banner",
  ];

  pickAdImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 720,
        maxHeight: 720,
      );

      if (image == null) return null;

      final imageTemporary = XFile(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (ex) {
      UiHelper.customErrorSnackBar(
        context,
        ex.message.toString(),
      );
    }
  }

  loadUserData() async {
    await HelperFunctions.getAdvBrandNameSF().then((val) {
      setState(() {
        brandName = val!;
      });
    });

    await HelperFunctions.getAdvBrandURLSF().then((val) {
      setState(() {
        brandURL = val!;
      });
    });
  }

  @override
  void initState() {
    loadUserData();
    getAllActiveSubscriptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4.0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        title: Text(
          brandName,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    pickAdImage(ImageSource.gallery);
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 4.0,
                    child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(image!.path),
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.fill,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/No-Image-Available.png",
                                filterQuality: FilterQuality.high,
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  thickness: 0.7,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  brandURL,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ).centered(),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: adTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                  validator: (value) {
                    if (value!.isEmpty && value == "") {
                      return "Please enter ad title";
                    }
                    if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                      return "Name should be in Alphanumeric form";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Ad title',
                    prefixIcon: Icon(
                      Icons.label_important_outline_rounded,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).canvasColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: Theme.of(context).brightness != Brightness.dark
                          ? const BorderSide(
                              width: 1,
                              color: Color(0xFF4F5359),
                            )
                          : const BorderSide(
                              width: 1,
                              color: Color(0xFFE6E6E7),
                            ),
                    ),
                  ),
                  child: Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(16),
                        dropdownColor: Theme.of(context).cardColor,
                        elevation: 4,
                        value: adCategory,
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                          color: Theme.of(context).shadowColor,
                        ),
                        isExpanded: true,
                        items: adCategoryList.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            adCategory = value!;
                          });
                        },
                      ).px16(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).canvasColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: !context.isDarkMode
                          ? const BorderSide(
                              width: 1,
                              color: Color(0xFF4F5359),
                            )
                          : const BorderSide(
                              width: 1,
                              color: Color(0xFFE6E6E7),
                            ),
                    ),
                  ),
                  child: Center(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: Theme.of(context).cardColor,
                      elevation: 4,
                      value: adType,
                      icon: Icon(
                        CupertinoIcons.chevron_down,
                        color: Theme.of(context).shadowColor,
                      ),
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: adTypes.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          adType = value!;
                        });
                      },
                    ).px16(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      elevation: 4.0,
                      builder: (context) {
                        return Wrap(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Choose plan according your needs",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayMedium,
                            ).centered(),
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              thickness: 1,
                              color: Theme.of(context).shadowColor,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              itemCount: subscriptions.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  elevation: 8.0,
                                  child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        planName =
                                            subscriptions[index].planName;
                                        planPrice =
                                            subscriptions[index].planPrice;
                                        noOfViews =
                                            subscriptions[index].noOfViews;
                                      });
                                      Navigator.pop(context);
                                    },
                                    leading: Icon(
                                      CupertinoIcons.money_dollar,
                                      color: Theme.of(context).shadowColor,
                                    ),
                                    title: Text(
                                      subscriptions[index].planName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    subtitle: Text(
                                      "${subscriptions[index].planPrice}₹",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    trailing: Text(
                                      "${subscriptions[index].noOfViews.toString()}Views",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ).pSymmetric(v: 2),
                                );
                              },
                            ),
                          ],
                        ).p(8);
                      },
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        width: 1,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            "Your Plan",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          trailing: Icon(
                            CupertinoIcons.chevron_down,
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: Theme.of(context).shadowColor,
                          ),
                          title: Text(
                            planName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(
                            "$planPrice₹",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          trailing: Text(
                            "${noOfViews.toString()} Views",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ).pSymmetric(v: 6),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CupertinoButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        uploadNewAd();
                      }
                    },
                    color: const Color(0xffFFE501),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Color(0xFF3C096C),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ).pSymmetric(h: 8, v: 4),
          ),
        ),
      ),
    );
  }

  Future uploadImageInStorage() async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          "Advertisement/${DateTime.now().millisecondsSinceEpoch}-$brandName-ad-image.jpg");
      await ref.putFile(
        File(image!.path),
      );
      final url = await ref.getDownloadURL();
      if (url != "") {
        return url.toString();
      } else {
        return "";
      }
    } on FirebaseException catch (ex) {
      return ex.message.toString();
    } on FormatException catch (ex) {
      return ex.message.toString();
    } on PlatformException catch (ex) {
      return ex.message.toString();
    } catch (ex) {
      return ex.toString();
    }
  }

  uploadNewAd() async {
    if (image == null) {
      UiHelper.customAlertBox(context, "Please Select an Image");
    } else if (adCategory == "Choose an Ad Category" &&
        adType == "Choose an Ad Type") {
      UiHelper.customAlertBox(
          context, "Please Choose an Ad Category and Ad Type");
    } else {
      UiHelper.customWaitingModel(
        context,
        "Wait a moment\n\nWe Process your request\n\nIt may be take time if your internet connection is working bad.",
      );
      await uploadImageInStorage().then((value) {
        if (value != null) {
          setState(() {
            imagePath = value;
          });
        } else {
          UiHelper.customErrorSnackBar(
            context,
            value.toString(),
          );
        }
      });
      await adService
          .addNewAdvertisement(
        advId,
        adTitle.text.toString(),
        brandURL,
        adCategory,
        imagePath,
      )
          .then(
        (value) {
          if (value != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdvPaymentService(
                  adId: value.toString(),
                  advId: advId,
                  brandName: brandName,
                  brandURL: brandURL,
                  adTitle: adTitle.text.toString(),
                  adImageUrl: imagePath,
                  adCategory: adCategory,
                  adType: adType,
                  subscriptionName: planName,
                  adPrice: planPrice,
                  noOfViews: noOfViews,
                ),
              ),
            );
          } else {
            UiHelper.customErrorSnackBar(
              context,
              "Error Occured...",
            );
          }
        },
      );
    }
  }
}
