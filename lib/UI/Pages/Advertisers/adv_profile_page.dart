import 'package:ad_brokers/Helpers/helper_function.dart';
import 'package:ad_brokers/Services/auth_service.dart';
import 'package:ad_brokers/UI/Pages/Advertisers/adv_edit_profile_page.dart';
import 'package:ad_brokers/UI/Widgets/profile_option_list_template.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AdvProfilePage extends StatefulWidget {
  const AdvProfilePage({super.key});

  @override
  State<AdvProfilePage> createState() => _AdvProfilePageState();
}

class _AdvProfilePageState extends State<AdvProfilePage> {
  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userRole = "";
  String userImageUrl = "";
  AuthService authService = AuthService();
  bool isImageLoaded = false;

  @override
  void initState() {
    super.initState();
    gettingUserData();
    loadImage();
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

    await HelperFunctions.getUserImageUrlSF().then((val) {
      setState(() {
        userImageUrl = val!;
      });
    });
  }

  loadImage() async {
    setState(() {
      isImageLoaded = false;
    });
    await Future.delayed(
      const Duration(seconds: 2),
      () => loadUserProfileImage(),
    );
    setState(() {
      isImageLoaded = true;
    });
  }

  Widget loadUserProfileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        userImageUrl,
        fit: BoxFit.fill,
        height: 56,
        width: 56,
        filterQuality: FilterQuality.high,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
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
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: SizedBox(
                height: 56,
                width: 56,
                child: isImageLoaded != true
                    ? const CupertinoActivityIndicator(
                        color: Colors.grey,
                      ).scale(scaleValue: 1.4)
                    : userImageUrl == ""
                        ? CircleAvatar(
                            backgroundColor: const Color(0xffFFE501),
                            child: Text(
                              userName[0].toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xFF3C096C),
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                              ),
                            ),
                          )
                        : loadUserProfileImage(),
              ),
              title: Text(
                userName,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userEmail,
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    userPhone,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvEditProfilePage(
                        userName: userName.toString(),
                        userEmail: userEmail.toString(),
                        userContact: userPhone.toString(),
                        userRole: userRole.toString(),
                        userImageUrl: userImageUrl.toString(),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).shadowColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Divider(
              thickness: 0.4,
              color: Theme.of(context).shadowColor,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "My Role",
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5.0,
            ),
            ListTile(
              leading: ImageIcon(
                const AssetImage("assets/icons/user_role.png"),
                color: Theme.of(context).shadowColor,
              ).scale(scaleValue: 1.3),
              title: Text(
                userRole,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              trailing: Icon(
                CupertinoIcons.info,
                color: Theme.of(context).shadowColor,
              ).scale(scaleValue: 1.1).tooltip("Information About Your Role"),
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 1,
              color: Colors.blueGrey,
            ),
            const SizedBox(
              height: 5,
            ),
            ProfileOptionListTemplate(
              icon: CupertinoIcons.settings,
              menuName: "Settings",
              callbackFunction: () {},
            ),
            ProfileOptionListTemplate(
              icon: Icons.follow_the_signs,
              menuName: "Follow Us",
              callbackFunction: () {},
            ),
            ProfileOptionListTemplate(
              icon: Icons.business_rounded,
              menuName: "Business Details",
              callbackFunction: () {
                Navigator.pushNamed(context, "/adv/showAdvBusinessDetailsPage");
              },
            ),
            ProfileOptionListTemplate(
              icon: CupertinoIcons.doc_append,
              menuName: "Documentation",
              callbackFunction: () {},
            ),
            ProfileOptionListTemplate(
              icon: Icons.question_answer,
              menuName: "F&Q",
              callbackFunction: () {},
            ),
            ProfileOptionListTemplate(
              icon: Icons.extension,
              menuName: "Appearance",
              callbackFunction: () {},
            ),
            const SizedBox(
              height: 4,
            ),
            GestureDetector(
              onTap: () {
                authService.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/checkUserStatus", (route) => false);
              },
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.redAccent,
                ).scale(scaleValue: 1.1),
                title: Text(
                  "Logout",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ).px(6),
          ],
        ).pSymmetric(v: 8.0, h: 16.0),
      ),
    );
  }
}
