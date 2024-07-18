import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/category/x_card.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/all_brands/brands_widgets/brand_products.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../texts/section_heading.dart';

class AllBrandsPage extends StatelessWidget {
  const AllBrandsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///! Heading
              const SectionHeading(title: 'Brands', showActionButton: false),
              const SizedBox(height: Sizes.spaceBtwItems),

              ///! -- Brands
              MyGridLayout(
                itemCount: 10,
                mainAxisExtent: 80,
                itemBuilder: (context, index) => XCard(
                  margin: 4,
                  showBorder: true,
                  onTap: () => Get.to(
                    () => BrandProducts(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
