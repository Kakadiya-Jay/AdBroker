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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        elevation: 2.0,
        title: Text(
          "About Us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to About Us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
