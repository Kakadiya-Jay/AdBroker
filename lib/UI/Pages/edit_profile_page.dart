// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userContact;
  final String userRole;

  const EditProfilePage(
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
                    Container(
                      height: 140,
                      width: 140,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                              height: 120,
                              width: 120,
                            )
                          : Image.asset(
                              "assets/images/Google.png",
                              fit: BoxFit.fill,
                              filterQuality: FilterQuality.high,
                              height: 120,
                              width: 120,
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
                          onPressed: () {},
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
            ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                TextFormField(
                  initialValue: widget.userName,
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
                onPressed: () {},
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
