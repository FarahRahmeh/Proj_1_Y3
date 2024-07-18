import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/category/x_card.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

import '../../products/sortable/sortable_products.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('xBook'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///! Brand Detail
              XCard(showBorder: true),
              SizedBox(height: Sizes.spaceBtwItems),
              SortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
