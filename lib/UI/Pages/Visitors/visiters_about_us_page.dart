import 'package:flutter/material.dart';

class VisitorSideAboutUsPage extends StatefulWidget {
  const VisitorSideAboutUsPage({super.key});

  @override
  State<VisitorSideAboutUsPage> createState() => _VisitorSideAboutUsPageState();
}

class _VisitorSideAboutUsPageState extends State<VisitorSideAboutUsPage> {
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
