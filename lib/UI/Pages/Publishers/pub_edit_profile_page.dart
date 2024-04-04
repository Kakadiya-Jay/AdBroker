// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/Services/database_service.dart';
import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class PubEditProfilePage extends StatefulWidget {
  String userName;
  String userEmail;
  String userContact;
  String userRole;
  String userImageUrl;

  PubEditProfilePage({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userContact,
    required this.userRole,
    required this.userImageUrl,
  });

  @override
  State<PubEditProfilePage> createState() => _PubEditProfilePageState();
}

class _PubEditProfilePageState extends State<PubEditProfilePage> {
  XFile? image;
  String imageUrl = "";
  final formkey = GlobalKey<FormState>();

  final authService = AuthService();
  final _auth = FirebaseAuth.instance;

  //Pick the Image From Device.
  pickProfileImage(ImageSource source) async {
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

  //Upload Image inside the Storage.
  Future uploadImageToStorage() async {
    try {
      User? user = _auth.currentUser;
      String uid = user!.uid;
      final ref = FirebaseStorage.instance.ref().child("Profiles/$uid.jpg");
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

  @override
  void initState() {
    imageUrl = widget.userImageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    pickProfileImage(ImageSource.gallery);
                  },
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(image!.path),
                                  fit: BoxFit.fill,
                                  filterQuality: FilterQuality.high,
                                  height: 120,
                                  width: 120,
                                ),
                              )
                            : widget.userImageUrl == ""
                                ? CircleAvatar(
                                    backgroundColor: const Color(0xffFFE501),
                                    child: Text(
                                      widget.userName[0].toUpperCase(),
                                      style: const TextStyle(
                                        color: Color(0xFF3C096C),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 72,
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      widget.userImageUrl,
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.high,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color(0xffFFE501),
                          ),
                          child: const Icon(
                            Icons.add_a_photo,
                            color: Color(0xFF3C096C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CupertinoButton(
                  onPressed: image == null
                      ? null
                      : () async {
                          UiHelper.customSnackBar(
                            context,
                            "Wait A Moment,\nImage is stored in a moment",
                          );
                          await uploadImageToStorage().then((value) {
                            if (value != null) {
                              UiHelper.customAlertBox(
                                context,
                                "Image Uploaded SuccessFully",
                              );
                              setState(() {
                                imageUrl = value.toString();
                              });
                            } else {
                              UiHelper.customErrorSnackBar(
                                  context, value.toString());
                            }
                          });
                        },
                  color: const Color(0xffFFE501),
                  child: const Text(
                    "Upload Image",
                    style: TextStyle(
                      color: Color(0xFF3C096C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.userRole,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                const Divider(height: 1, thickness: 0.1),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: widget.userName,
                  style: Theme.of(context).textTheme.displaySmall,
                  onChanged: (value) {
                    setState(() {
                      widget.userName = value.trim();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "User Name",
                    hintText: "Tony Howard Stark",
                    prefixIcon: Icon(
                      CupertinoIcons.person,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.userEmail,
                  style: Theme.of(context).textTheme.displaySmall,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() {
                      widget.userEmail = value.trim();
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "helloNew77@gmail.com",
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    widget.userContact = value.trim();
                  },
                  keyboardType: TextInputType.phone,
                  initialValue: widget.userContact,
                  style: Theme.of(context).textTheme.displaySmall,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelText: "Contact",
                    hintText: "9978******",
                    prefixIcon: Icon(
                      CupertinoIcons.phone,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: CupertinoButton(
                    onPressed: () {
                      if (widget.userName != "" &&
                          widget.userEmail != "" &&
                          widget.userContact != "") {
                        updateAdvertiserProfile();
                      } else {
                        UiHelper.customFailureAlertBox(
                            context, "Enter Required Fields");
                      }
                    },
                    color: const Color(0xffFFE501),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(
                        color: Color(0xFF3C096C),
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ).p8(),
          ),
        ),
      ),
    );
  }

  updateAdvertiserProfile() async {
    UiHelper.customSnackBar(context,
        "Wait Your Profile Updated in few Second. \nDon't Close the Screen");
    DatabaseService(
      uid: _auth.currentUser!.uid.toString(),
    )
        .updatePublisherProfile(
      widget.userName,
      widget.userEmail,
      widget.userContact,
      imageUrl,
    )
        .then((value) async {
      if (value == true) {
        await HelperFunctions.saveUserNameSF(widget.userName);
        await HelperFunctions.saveUserEmailSF(widget.userEmail);
        await HelperFunctions.saveUserContactSF(widget.userContact);
        await HelperFunctions.saveUserImageURLSF(imageUrl);
        UiHelper.customSnackBar(context, "Profile Updated SuccessFully");
        Navigator.pushNamedAndRemoveUntil(
            context, "/pub/frontPage", (route) => false);
      } else {
        UiHelper.customErrorSnackBar(context, value.toString());
      }
    });
  }
}
