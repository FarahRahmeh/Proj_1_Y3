import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

class StackedWithImageContainer extends StatelessWidget {
  StackedWithImageContainer({
    Key? key,
    this.image = Images.heartbot,
    this.text = 'Blahhhhhhhhhhh',
    this.backgroundColor = gray,
    this.textColor = brown,
    this.height = 200,
    this.width = 160,
    this.onTap,
  }) : super(key: key);

  final String image;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double width, height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 10,
            child: RoundedContainer(
              width: width,
              height: height,
              radius: 20.0,
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor: backgroundColor,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            child: Container(
              width: width - 70, // Set the width of your image
              height: width - 70, // Set the height of your image
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(image), // Load image from the URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
