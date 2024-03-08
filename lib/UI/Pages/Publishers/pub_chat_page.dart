import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PubChatPage extends StatefulWidget {
  const PubChatPage({super.key});

  @override
  State<PubChatPage> createState() => _PubChatPageState();
}

class _PubChatPageState extends State<PubChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 2.0,
        title: Text(
          "Chat",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        centerTitle: true,
      ),
      body: Text(
        "Chat Page",
        style: Theme.of(context).textTheme.displayMedium,
      ).centered(),
    );
  }
}
