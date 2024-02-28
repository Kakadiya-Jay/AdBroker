// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ad_brokers/UI/Widgets/uihelper.dart';
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
  File? image;
  String enterpriseNameText = "";
  String categoryText = "";

  pickAdImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return null;

      final imageTemporary = File(image.path);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'New Ad',
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  pickAdImage(ImageSource.gallery);
                },
                child: Card(
                  color: Colors.transparent,
                  elevation: 2.0,
                  child: SizedBox(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            "assets/images/No-Image-Available.png",
                            fit: BoxFit.contain,
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
              TextFormField(
                onChanged: (value) {
                  if (value != "") {
                    setState(() {
                      enterpriseNameText = value;
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'EnterPrise Name',
                  // enabled: false,
                  filled: true,
                  fillColor: Color.fromARGB(255, 194, 194, 194),
                  prefixIcon: Icon(CupertinoIcons.person),
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
              TextFormField(
                onChanged: (value) {
                  if (value != "") {
                    setState(() {
                      categoryText = value;
                    });
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Ads category',
                  hintText: "Enter Ads category",
                  // enabled: false,
                  filled: true,
                  fillColor: Color.fromARGB(255, 194, 194, 194),
                  prefixIcon: Icon(CupertinoIcons.doc_chart),
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
              Card(
                color: Colors.grey,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(width: 1, color: Colors.black)),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(Icons.currency_rupee_rounded),
                        title: Text("Choose Plan"),
                        trailing: Icon(CupertinoIcons.right_chevron),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "899₹",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "28 Days",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(
                            "10k-20k",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ).pSymmetric(h: 20).pOnly(bottom: 8),
                    ],
                  ).pSymmetric(v: 6),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton(
                onPressed: () {
                  if (image == null) {
                    UiHelper.customAlertBox(context, "Please Select an Image");
                  } else if (enterpriseNameText == "" && categoryText == "") {
                    UiHelper.customAlertBox(context, "Please Enter All Fields");
                  } else {
                    UiHelper.customErrorSnackBar(
                      context,
                      "Ad Uploaded Successfully",
                    );
                    Navigator.pop(context);
                  }
                },
                color: Colors.deepPurple,
                child: const Text("Upload New Ad"),
              ),
            ],
          ).pSymmetric(h: 8, v: 4),
        ),
      ),
    );
  }
}
