import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // GestureDetector(
                      //   onTap: () {},
                      //   child: Container(
                      //     height: 48,
                      //     width: 48,
                      //     decoration: ShapeDecoration(
                      //       color: const Color(0xFFF5F5F5),
                      //       shape: RoundedRectangleBorder(
                      //         side: const BorderSide(
                      //             width: 1.0, color: Colors.black),
                      //         borderRadius: BorderRadius.circular(16),
                      //       ),
                      //     ),
                      //     child: const Icon(
                      //       Icons.attach_file_rounded,
                      //       color: Color(0xFF163648),
                      //     ),
                      //   ),
                      // ),
                      // const Spacer(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 48,
                        child: TextFormField(
                          controller: messageText,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              color: const Color(0xFF163648),
                              onPressed: () {
                                if (messageText.text.isNotEmpty ||
                                    messageText.text != "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Message Send Successfully....",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      backgroundColor: const Color.fromARGB(
                                          255, 159, 187, 203),
                                      elevation: 6.0,
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Oops.., It's Seems like you put empty the message field..",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
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
                            fillColor: const Color(0xFFE6E3E9),
                            hintText: "Type Message...",
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.black),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
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
