import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

class MyBottomSheet extends StatelessWidget {
  const MyBottomSheet(
      {super.key,
      this.title = 'Custom Bottom Sheet',
      this.child = const SizedBox.shrink()});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: 200,
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
