import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MakeUserDpCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final String email;
  final String phone;
  const MakeUserDpCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      children: [
        Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width * 0.81,
                  child: imagePath == ""
                      ? Image.asset(
                          "assets/images/no-profile-image.png",
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                          height: 250,
                          width: MediaQuery.of(context).size.width * 0.81,
                        )
                      : Image.network(
                          imagePath,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                          height: 250,
                          width: MediaQuery.of(context).size.width * 0.80,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).shadowColor,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width * 0.80,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(180, 30, 30, 30),
                  ),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xfff9feff),
                    ),
                  ).pOnly(left: 8.0, top: 4.0),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    CupertinoIcons.mail,
                    color: Theme.of(context).shadowColor,
                  ),
                  title: Text(
                    email,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    CupertinoIcons.phone,
                    color: Theme.of(context).shadowColor,
                  ),
                  title: Text(
                    phone,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
