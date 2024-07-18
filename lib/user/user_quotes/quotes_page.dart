import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: false,
        title: Text('Quotes and Notes'),
      ),
    );
  }
}
