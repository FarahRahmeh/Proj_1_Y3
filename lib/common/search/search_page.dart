import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user/user_all_books/all_books_controller.dart';
import '../widgets/layouts/grid_layout.dart';
import '../widgets/products/product_card/product_card_vertical.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final AllBooksController allBooksController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: TextFormField(
                    decoration: InputDecoration(
                        suffixIconColor: Colors.white,
                        focusedBorder: InputBorder.none,
                        // focusedBorder: UnderlineInputBorder(
                        //   borderSide: BorderSide(
                        //     color: Color.fromARGB(255, 63, 178, 196),
                        //     width: 2.0,
                        //   ),
                        // ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            allBooksController.clearSearch();
                          },
                          icon: Icon(Icons.close),
                        )),
                    controller: allBooksController.searchController,
                    onChanged: (value) {
                      allBooksController.addSearchToList(value);
                    },
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: beige2),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView(children: [
                MyGridLayout(
                  itemCount: allBooksController.searchList.length,
                  itemBuilder: (_, index) => ProductCardVertical(
                    allbooks: allBooksController.searchList[index],
                  ),
                ),
              ]),
            ),
          ),
          // Expanded(
          //   child: Obx(
          //     () => ListView.builder(
          //         itemCount: allBooksController.searchList.length,
          //         itemBuilder: (context, index) {
          //           return ProductCardVertical(
          //             allbooks: allBooksController.searchList[index],
          //           );
          //         }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
