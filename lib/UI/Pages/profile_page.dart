import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userRole = "";
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });

    await HelperFunctions.getUserEmailFromSF().then((val) {
      setState(() {
        userEmail = val!;
      });
    });

    await HelperFunctions.getUserContactFromSF().then((val) {
      setState(() {
        userPhone = val!;
      });
    });

    await HelperFunctions.getUserRoleFromSF().then((val) {
      setState(() {
        userRole = val!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/images/Google.png",
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xffFFE501),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.plus,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              userName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              userRole,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Text(
              userEmail,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              userPhone,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFE501),
                  side: BorderSide.none,
                  elevation: 1.0,
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  "Edit Profile",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Divider(height: 1, thickness: 0.1),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {
                  authService.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/loginPage", (route) => false);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                ),
              ),
              title: GestureDetector(
                onTap: () {
                  authService.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/loginPage", (route) => false);
                },
                child: Text(
                  "Logout",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(color: Colors.redAccent),
                ),
              ),
            ),
          ],
        ).pSymmetric(v: 12.0, h: 24.0).centered(),
      ),
    );
  }
}
