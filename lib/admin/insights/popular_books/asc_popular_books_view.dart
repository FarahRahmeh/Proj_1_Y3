import 'package:booktaste/admin/insights/popular_books/popular_books_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularAscBooksPage extends StatelessWidget {
  final controller = Get.put(PopularBooksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Popular Books by Readers Count'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isBooksLoading.value) {
          return Center(
              child: CircularProgressIndicator(
            color: lightBrown,
          ));
        }
        if (controller.bookListAsc.isEmpty || controller.bookListDesc.isEmpty) {
          return Center(child: Text('No books available'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                Text('Ascending Order'),
                SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      clipBehavior: Clip.none,
                      padding: EdgeInsets.only(top: Sizes.defaultSpace),
                      width: controller.bookListAsc.length * 50.0,
                      child: BarChart(
                        BarChartData(
                          barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: lightBrown.withOpacity(0.7),
                              getTooltipItem:
                                  (group, groupIndex, rod, rodIndex) {
                                int index = groupIndex;
                                if (index >= 0 &&
                                    index < controller.bookListAsc.length) {
                                  var book = controller.bookListAsc[index];
                                  return BarTooltipItem(
                                    "${book.name}" '\n',
                                    TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(text: book.bookId ?? ''),
                                      TextSpan(
                                          text: '\n' +
                                              book.readPercent.toString() +
                                              '%'),
                                    ],
                                  );
                                }
                                return null;
                              },
                            ),
                          ),
                          gridData: FlGridData(drawVerticalLine: false),
                          barGroups: controller
                              .getBarChartData(controller.bookListAsc),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: lightBrown.withOpacity(0.3),
                            ),
                          ),
                          titlesData: FlTitlesData(
                            topTitles: SideTitles(
                              showTitles: false,
                              getTitles: (double value) {
                                int index = value.toInt();
                                if (index >= 0 &&
                                    index < controller.bookListAsc.length) {
                                  return controller
                                          .bookListAsc[index].readPercent
                                          .toString() +
                                      '%';
                                }
                                return '';
                              },
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              getTitles: (double value) {
                                int index = value.toInt();
                                return index.toString() + '%';
                              },
                              getTextStyles: (context, value) {
                                return const TextStyle(fontSize: 10);
                              },
                            ),
                            rightTitles: SideTitles(showTitles: false),
                            bottomTitles: SideTitles(
                              rotateAngle: 90,
                              showTitles: true,
                              getTitles: (double value) {
                                int index = value.toInt();
                                if (index >= 0 &&
                                    index < controller.bookListAsc.length) {
                                  return controller.bookListAsc[index].name ??
                                      '';
                                }
                                return '';
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
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
