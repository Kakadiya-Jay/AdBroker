// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilePage extends StatefulWidget {
  String userName;
  String userEmail;
  String userContact;
  String userRole;

  EditProfilePage(
      {super.key,
      required this.userName,
      required this.userEmail,
      required this.userContact,
      required this.userRole});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? image;

  pickProfileImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return null;

      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ex.message.toString()),
        ),
      );
    }
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
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
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
                                image!,
                                fit: BoxFit.fill,
                                filterQuality: FilterQuality.high,
                                height: 120,
                                width: 120,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                "assets/images/Google.png",
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
                        child: IconButton(
                          onPressed: () {
                            pickProfileImage(ImageSource.gallery);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
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
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                TextFormField(
                  initialValue: widget.userName,
                  onChanged: (value) {
                    setState(() {
                      widget.userName = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "User Name",
                    filled: true,
                    fillColor: const Color.fromARGB(255, 194, 194, 194),
                    prefixIcon: const Icon(CupertinoIcons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.userEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    widget.userEmail = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    filled: true,
                    fillColor: const Color.fromARGB(255, 194, 194, 194),
                    prefixIcon: const Icon(CupertinoIcons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    widget.userContact = value;
                  },
                  keyboardType: TextInputType.phone,
                  initialValue: widget.userContact,
                  decoration: InputDecoration(
                    labelText: "Contact",
                    filled: true,
                    fillColor: const Color.fromARGB(255, 194, 194, 194),
                    prefixIcon: const Icon(CupertinoIcons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: CupertinoButton(
                onPressed: () {
                  if (widget.userName == "" &&
                      widget.userEmail == "" &&
                      widget.userContact == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Please fill all the fields",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        backgroundColor: Colors.redAccent,
                        elevation: 4.0,
                      ),
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                color: const Color(0xffFFE501),
                child: const Text(
                  "Edit Profile",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const Spacer(),
          ],
        ).p8(),
      ),
    );
  }
}
