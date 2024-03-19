// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Models/subscription_model.dart';
import 'package:ad_brokers/Services/ads_service.dart';
import 'package:ad_brokers/Services/subscription_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  final adRedirect = TextEditingController();
  String adCategory = "Choose an Ad Category";
  String adType = "Choose an Ad Type";
  XFile? image;
  String imagePath = "";
  final _adservice = AdService();
  final _subsriptionservice = SubscriptionService();
  List<SubscriptionModel> subscriptions = [];
  String planName = "";
  num planPrice = 0;
  num noOfViews = 0;
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
    "Product",
    "Education",
    "Gadgets",
    "Institute",
    "E-commerce",
    "Loan",
    "Finance",
    "Movie",
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
                  thickness: 0.1,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  brandURL,
                  style: Theme.of(context).textTheme.displaySmall,
                ).centered(),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: adTitle,
                  validator: (value) {
                    if (value!.isEmpty && value == "") {
                      return "Please enter ad title";
                    }
                    if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                      return "Name should be in Alphanumeric form";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Ad title',
                    filled: true,
                    fillColor: Color.fromARGB(255, 194, 194, 194),
                    prefixIcon: Icon(Icons.label_important_outline_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(width: 1),
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
                    color: const Color.fromARGB(255, 194, 194, 194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Center(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: const Color.fromARGB(255, 194, 194, 194),
                      elevation: 4,
                      value: adCategory,
                      icon: const Icon(
                        CupertinoIcons.chevron_down,
                      ),
                      isExpanded: true,
                      items: adCategoryList.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
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
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: const Color.fromARGB(255, 194, 194, 194),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Center(
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(16),
                      dropdownColor: const Color.fromARGB(255, 194, 194, 194),
                      elevation: 4,
                      value: adType,
                      icon: const Icon(
                        CupertinoIcons.chevron_down,
                      ),
                      isExpanded: true,
                      items: adTypes.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
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
                      builder: (context) {
                        return Wrap(
                          children: [
                            const Text(
                              "Choose Plans",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFFE501),
                              ),
                            ).centered(),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Choose plan according your needs",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall,
                            ).centered(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            ListView.builder(
                              itemCount: subscriptions.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      planName = subscriptions[index].planName;
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
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
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
                                );
                              },
                            ).pSymmetric(h: 16),
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
                            style: Theme.of(context).textTheme.displaySmall,
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
                CupertinoButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      uploadNewAd();
                    }
                  },
                  color: Colors.deepPurple,
                  child: const Text("Upload New Ad"),
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
      UiHelper.customAlertBox(context,
          "Wait a moment\nWe Process your request\nYou can close this Dialog Box");
      await uploadImageInStorage().then((value) {
        if (value != null) {
          setState(() {
            imagePath = value;
          });
          UiHelper.customSnackBar(
            context,
            "Ad Image successfully stored in storage",
          );
        } else {
          UiHelper.customErrorSnackBar(
            context,
            value.toString(),
          );
        }
      });
      UiHelper.customAlertBox(
          context, "Don't Close the screen\nAd will be uploaded soon");
      await _adservice
          .addNewAdvertisement(
        advId,
        adTitle.text.toString(),
        brandURL,
        adCategory,
        imagePath,
      )
          .then(
        (value) {
          if (value == true) {
            UiHelper.customSnackBar(
              context,
              "Ad Upload Successfully\nYour Ad Will be publish After Admin Confirmation.",
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/adv/frontPage",
              (route) => false,
            );
          } else {
            UiHelper.customErrorSnackBar(
              context,
              value.toString(),
            );
          }
        },
      );
    }
  }
}
