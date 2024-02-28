import 'package:flutter/material.dart';

class VisitorSideContactUsPage extends StatefulWidget {
  const VisitorSideContactUsPage({super.key});

  @override
  State<VisitorSideContactUsPage> createState() =>
      _VisitorSideContactUsPageState();
}

class _VisitorSideContactUsPageState extends State<VisitorSideContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Text(
          "Welcome to Contact Us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
