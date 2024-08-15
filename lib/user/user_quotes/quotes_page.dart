import 'dart:convert';

import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/data/repositories/quote_repository.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:booktaste/user/user_quotes/quotes_controller.dart';
import 'package:booktaste/user/user_quotes/quotes_widgets/add_new_quote_page.dart';
import 'package:booktaste/user/user_quotes/quotes_widgets/quote_card.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AllQuotesController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Quotes and Notes'),
        // actions: [
        //   //! New quote Btn
        //   IconButton(
        //     onPressed: () {
        //       Get.to(() => QuoteForm());
        //     },
        //     icon: Icon(Iconsax.save_add_copy),
        //   )
        // ],
      ),
      body: RefreshIndicator(
        color: beige,
        backgroundColor: lightBrown.withOpacity(0.5),
        onRefresh: ctrl.refreshQuotes,
        child: Obx(() {
          if (ctrl.allQuotesIsLoading.value) {
            return Center(
              child: Image.asset(
                width: 90,
                Images.coffeeLoading,
              ),
            );
          } else if (ctrl.quotes.isEmpty) {
            return Center(child: Image.asset(Images.quoteCoffee));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: MyGridLayout(
                  crossAxisCount: 1,
                  itemCount: ctrl.quotes.length,
                  itemBuilder: (_, index) {
                    print(jsonEncode(ctrl.quotes[index]));
                    Quote quote = ctrl.quotes[index];
                    return QuoteCard(quote: quote);
                  },
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
