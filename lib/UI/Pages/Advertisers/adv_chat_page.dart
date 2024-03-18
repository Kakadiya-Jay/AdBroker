import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdvChatPage extends StatefulWidget {
  const AdvChatPage({super.key});

  @override
  State<AdvChatPage> createState() => _AdvChatPageState();
}

class _AdvChatPageState extends State<AdvChatPage> {
  var messageText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 165, 169, 182),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.33,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextFormField(
                    controller: messageText,
                    maxLength: 256,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        color: const Color(0xFF163648),
                        onPressed: () {
                          if (messageText.text.isNotEmpty ||
                              messageText.text != "") {
                            UiHelper.customSnackBar(
                              context,
                              "Message Send Successfully....",
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Oops.., It's Seems like you put empty the message field..",
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  actions: [
                                    CupertinoButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 194, 194, 194),
                      hintText: "Type Message...",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Color(0xFF4F5359),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
