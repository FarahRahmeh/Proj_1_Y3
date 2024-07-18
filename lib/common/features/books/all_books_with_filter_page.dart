import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/category/x_card.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../widgets/products/sortable/sortable_products.dart';

class AllBooksWithFilter extends StatelessWidget {
  const AllBooksWithFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('All Books'),
        showBackArrow: true,
        leadingIcon: Iconsax.search_status_1_copy,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///! Brand Detail
           //   XCard(showBorder: true),
              SizedBox(height: Sizes.spaceBtwItems),
              SortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
