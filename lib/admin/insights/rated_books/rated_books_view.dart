import 'package:booktaste/admin/insights/rated_books/rated_books_controller.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/dropdown_button_form_field/my_dorpdown_btn_form_field.dart';
import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatedBooksPage extends StatelessWidget {
  final booksCtrl = Get.put(RatedBooksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Books by Rating'),
      ),
      body: Obx(() {
        if (booksCtrl.isBooksLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                MyDropdownBtnFormField(
                  items: ['Descending', 'Ascending'],
                  onChanged: (value) {
                    if (value != null) {
                      if (value == 'Ascending') {
                        booksCtrl.updateSortOrder('asc');
                      } else {
                        booksCtrl.updateSortOrder('desc');
                      }
                    }
                  },
                  label: 'Order by',
                  hintText: booksCtrl.selectedSortOrder.toString(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: booksCtrl.bookList.length,
                    itemBuilder: (context, index) {
                      final book = booksCtrl.bookList[index];
                      return RoundedContainer(
                        showBorder: true,
                        borderColor: lightBrown.withOpacity(0.5),
                        margin: const EdgeInsets.symmetric(
                          vertical: Sizes.sm,
                        ),
                        child: ListTile(
                          leading: SizedBox(
                            width: 40,
                            height: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Sizes.sm),
                              child: MyNetworkImage(
                                shWidth: 40,
                                shHeight: 80,
                                notFoundImage: Images.defaultBookCover,
                                imageUrl: book.cover.toString(),
                              ),
                            ),
                          ),
                          title: Text(book.name ?? 'No Name'),
                          subtitle: Text(book.writer ?? 'No Author'),
                          trailing: Column(
                            children: [
                              Text('${book.stars} ★'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
