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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).shadowColor,
        ),
        elevation: 2.0,
        title: Text(
          "Contact Us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to Contact Us",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
