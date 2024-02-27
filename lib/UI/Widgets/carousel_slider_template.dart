import 'package:ad_brokers/UI/Widgets/uihelper.dart';
import 'package:flutter/material.dart';

class CarouselSliderItems extends StatelessWidget {
  final String imagePath;
  const CarouselSliderItems({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UiHelper.customSnackBar(context, "Please Register With Us");
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
