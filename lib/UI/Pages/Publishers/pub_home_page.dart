import 'package:flutter/material.dart';

class PubHomePage extends StatefulWidget {
  const PubHomePage({super.key});

  @override
  State<PubHomePage> createState() => _PubHomePageState();
}

class _PubHomePageState extends State<PubHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome Publisher",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
