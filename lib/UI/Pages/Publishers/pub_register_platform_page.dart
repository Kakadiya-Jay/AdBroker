import 'package:ad_brokers/Services/publisher_platform_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPlatformPage extends StatefulWidget {
  const RegisterPlatformPage({super.key});

  @override
  State<RegisterPlatformPage> createState() => _RegisterPlatformPageState();
}

class _RegisterPlatformPageState extends State<RegisterPlatformPage> {
  final formkey = GlobalKey<FormState>();
  final appName = TextEditingController();
  final bundleId = TextEditingController();
  final adCategory = TextEditingController();
  final redirectUrl = TextEditingController();

  final platformService = PublisherPlatformService();
  String apiKey = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ragister Platform",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 4.0,
      ),
      body: isLoading == true
          ? Center(
              child: CupertinoActivityIndicator(
                color: Theme.of(context).shadowColor,
              ).scale(scaleValue: 2),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Ragister your platform in which you want to run the Ads",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: appName,
                        style: Theme.of(context).textTheme.displaySmall,
                        validator: (value) {
                          if (value!.isEmpty && value == "") {
                            return "Please enter app name";
                          }
                          if (!value.contains(RegExp(r'[A-Z,a-z,0-9]'))) {
                            return "Name should be in Alphanumeric form";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'App Name',
                          hintText: 'Ex:- Testing App',
                          prefixIcon: Icon(
                            Icons.label_important_outline_rounded,
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: bundleId,
                        style: Theme.of(context).textTheme.displaySmall,
                        validator: (value) {
                          if (value!.isEmpty && value == "") {
                            return "Please enter bundle id";
                          }
                          if (!value.contains(RegExp(r'[A-Z,a-z,0-9,.]'))) {
                            return "Bundle id should be in Alphanumeric form";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Bundle Id',
                          hintText: 'Ex:- com.example.testing_app',
                          prefixIcon: Icon(
                            Icons.badge_rounded,
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: adCategory,
                        style: Theme.of(context).textTheme.displaySmall,
                        validator: (value) {
                          if (value!.isEmpty && value == "") {
                            return "Please enter ad Category";
                          }
                          if (!value.contains(RegExp(r'[A-Z,a-z]'))) {
                            return "Category should be in Alphabetical form";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Ad Category',
                          hintText: 'Ex:- Product',
                          prefixIcon: Icon(
                            Icons.category_rounded,
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: redirectUrl,
                        style: Theme.of(context).textTheme.displaySmall,
                        validator: (value) {
                          if (value!.isEmpty && value == "") {
                            return "Please enter redirect url";
                          }
                          if (!Uri.parse(value).isAbsolute) {
                            return "URL Format is incorrect";
                          }
                          // if (!value.contains(RegExp(
                          //     r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?"))) {
                          //   return "URL format is incorrect";
                          // }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Redirect URL',
                          hintText: 'Ex:- https://AdBrokers.com',
                          prefixIcon: Icon(
                            CupertinoIcons.link,
                            color: Theme.of(context).shadowColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            registerPlatform();
                          }
                        },
                        color: const Color(0xffFFE501),
                        child: const Text(
                          "Generate Api Key",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF3C096C),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "After Submitting a form you can see your Api Key Below",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      apiKey != ""
                          ? GestureDetector(
                              onLongPress: () {
                                Clipboard.setData(
                                  ClipboardData(text: apiKey),
                                );
                                UiHelper.customSnackBar(
                                  context,
                                  "Api Key Copied Successfully",
                                );
                              },
                              child: Card(
                                color: Theme.of(context).cardColor,
                                elevation: 4.0,
                                child: Text(
                                  apiKey,
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ).p16().centered(),
                              ),
                            )
                          : const Text(""),
                      const SizedBox(
                        height: 20,
                      ),
                      apiKey != ""
                          ? Text(
                              "You can Copy this API KEY by long pressing on it",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          : const Text(""),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ).p8(),
                ),
              ).centered(),
            ),
    );
  }

  registerPlatform() async {
    setState(() {
      isLoading = true;
    });
    await platformService
        .ragisterNewPlatform(
      appName.text.trim().toString(),
      FirebaseAuth.instance.currentUser!.uid.toString(),
      bundleId.text.trim().toString(),
      adCategory.text.trim().toString(),
      redirectUrl.text.trim().toString(),
    )
        .then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          apiKey = value.toString();
        });
      } else {
        UiHelper.customErrorSnackBar(
          context,
          "Something went wrong\nPlease Try Again..",
        );
      }
    });
  }
}
