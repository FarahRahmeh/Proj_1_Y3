import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/circular_container.dart';
import 'package:booktaste/user/user_statistics/genre_insights/genre_read_percent/genre_read_percent_controller.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../common/widgets/dropdown_button_form_field/my_dorpdown_btn_form_field.dart';
import '../../../../utils/constans/colors.dart';

class GenreReadPercentView extends StatelessWidget {
  final statsCtrl = Get.put(GenreReadPercentController());

  // Define a color mapping for genres

  @override
  Widget build(BuildContext context) {
    final Map<String, Color> colorMapping = {
      for (int i = 0; i < statsCtrl.genres.length; i++)
        statsCtrl.genres[i]: statsCtrl.colors[i % statsCtrl.colors.length],
    };
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Shelf Percent Statistics'),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            MyDropdownBtnFormField(
              items: ['asc', 'desc'],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  statsCtrl.fetchShelfReadPercent(newValue);
                }
              },
            ),
            SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            Expanded(
              child: Obx(() {
                if (statsCtrl.isGRPLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: statsCtrl.shelfReadPerc.length * 45.0,
                            child: BarChart(
                              BarChartData(
                                backgroundColor: gray.withOpacity(0.2),
                                barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: lightBrown.withOpacity(0.8),
                                    getTooltipItem:
                                        (group, groupIndex, rod, rodIndex) {
                                      String genre = statsCtrl
                                          .shelfReadPerc.keys
                                          .elementAt(group.x);
                                      int value =
                                          statsCtrl.shelfReadPerc[genre] ?? 0;
                                      return BarTooltipItem(
                                        '$genre\n$value%',
                                        TextStyle(
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  bottomTitles: SideTitles(
                                    rotateAngle: 90,
                                    showTitles: true,
                                    reservedSize: 100,
                                    getTitles: (double value) {
                                      int index = value.toInt();
                                      if (index >= 0 &&
                                          index <
                                              statsCtrl.shelfReadPerc.length) {
                                        String genre = statsCtrl
                                            .shelfReadPerc.keys
                                            .elementAt(index);
                                        return genre;
                                      }
                                      return '';
                                    },
                                    getTextStyles: (context, value) {
                                      return const TextStyle(
                                          color: lightBrown, fontSize: 12);
                                    },
                                  ),
                                  leftTitles: SideTitles(
                                    rotateAngle: 270,
                                    showTitles: true,
                                    getTitles: (value) {
                                      int index = value.toInt();
                                      return index.toString() + '';
                                    },
                                    getTextStyles: (context, value) {
                                      return const TextStyle(
                                          color: lightBrown, fontSize: 12);
                                    },
                                  ),
                                  rightTitles: SideTitles(showTitles: false),
                                  topTitles: SideTitles(showTitles: false),
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                  //   border: Border.all(
                                  //     color: gray,
                                  //   ),
                                ),
                                barGroups:
                                    getBarGroups(statsCtrl.shelfReadPerc),
                                gridData: FlGridData(
                                  show: false,
                                  // drawVerticalLine: false,
                                ),
                                alignment: BarChartAlignment.spaceAround,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: statsCtrl.shelfReadPerc.length,
                          itemBuilder: (context, index) {
                            String key =
                                statsCtrl.shelfReadPerc.keys.elementAt(index);
                            int value = statsCtrl.shelfReadPerc[key]!;
                            Color tileColor = colorMapping[key] ?? Colors.grey;
                            return ListTile(
                              title: Text(key),
                              trailing: Text(value.toString() + '%'),
                              leading: CircularContainer(
                                backgroundColor: tileColor,
                                width: 15,
                                height: 15,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups(Map<String, int> stats) {
    final Map<String, Color> colorMapping = {
      for (int i = 0; i < statsCtrl.genres.length; i++)
        statsCtrl.genres[i]: statsCtrl.colors[i % statsCtrl.colors.length],
    };

    return stats.entries.map((entry) {
      final genre = entry.key;
      final value = entry.value;

      Color barColor = colorMapping[genre] ?? Colors.grey;

      return BarChartGroupData(
        x: stats.keys.toList().indexOf(genre),
        barRods: [
          BarChartRodData(
            y: value.toDouble(),
            colors: [barColor],
            width: 16,
          ),
        ],
      );
    }).toList();
  }
}
