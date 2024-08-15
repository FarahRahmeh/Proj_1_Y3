import 'package:booktaste/admin/insights/genres_statistics/genres_stats_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../common/widgets/dropdown_button_form_field/my_dorpdown_btn_form_field.dart';

class GenresStatsPage extends StatelessWidget {
  final statsCtrl = Get.put(GenreStatsController());
  final Map<String, Color> colorMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shelf Statistics'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
              child: MyDropdownBtnFormField(
                hintText: 'Order by',
                items: ['asc', 'desc'],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    statsCtrl.fetchShelfStats(newValue);
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (statsCtrl.isStatsLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: EdgeInsets.all(Sizes.defaultSpace),
                  child: SizedBox(
                    height: 250,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: statsCtrl.shelfStats.length * 40.0,
                        child: BarChart(
                          BarChartData(
                            backgroundColor: gray.withOpacity(0.1),
                            barTouchData: BarTouchData(
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: lightBrown,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  String genre = statsCtrl.shelfStats.keys
                                      .elementAt(group.x);
                                  int value = statsCtrl.shelfStats[genre] ?? 0;
                                  return BarTooltipItem(
                                    '$genre\n$value%',
                                    TextStyle(color: Colors.white),
                                  );
                                },
                              ),
                              touchCallback:
                                  (FlTouchEvent event, barTouchResponse) {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  statsCtrl.touchedIndex.value = -1;
                                  return;
                                }
                                statsCtrl.touchedIndex.value =
                                    barTouchResponse.spot!.touchedBarGroupIndex;
                              },
                            ),
                            titlesData: FlTitlesData(
                              bottomTitles: SideTitles(
                                rotateAngle: 90,
                                showTitles: true,
                                reservedSize: 150,
                                getTitles: (double value) {
                                  int index = value.toInt();
                                  if (index >= 0 &&
                                      index < statsCtrl.shelfStats.length) {
                                    String genre = statsCtrl.shelfStats.keys
                                        .elementAt(index);

                                    return genre;
                                  }
                                  return '';
                                },
                                getTextStyles: (context, value) {
                                  return const TextStyle(
                                      color: Colors.black, fontSize: 12);
                                },
                              ),
                              leftTitles: SideTitles(
                                showTitles: true,
                                getTextStyles: (context, value) {
                                  return const TextStyle(
                                      color: Colors.black, fontSize: 12);
                                },
                              ),
                              rightTitles: SideTitles(showTitles: false),
                              topTitles: SideTitles(showTitles: false),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: getBarGroups(statsCtrl.shelfStats),
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                            ),
                            alignment: BarChartAlignment.spaceAround,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> getBarGroups(Map<String, int> stats) {
    final List<Color> colors = [
      Color(0xffFFD1DC), // pastel pink
      Color(0xffFFB347), // pastel orange
      Color(0xffFFD700), // pastel yellow
      Color(0xff9FE2BF), // pastel green
      Color(0xffB19CD9), // pastel purple
      Color(0xffFF6961), // pastel red
      Color(0xff77DD77), // pastel light green
      Color(0xffAEC6CF), // pastel blue
      Color(0xffF49AC2), // pastel magenta
      Color(0xffCFCFC4), // pastel grey
      Color(0xffFDFD96), // pastel light yellow
      Color(0xffDEA5A4), // pastel light red
      Color(0xff779ECB), // pastel medium blue
      Color(0xffB39EB5), // pastel violet
      Color(0xffFFB347), // pastel orange (light)
      Color(0xffC23B22), // pastel dark red
      Color(0xff03C03C), // pastel dark green
      Color(0xffFFEFDB), // pastel light orange
      Color(0xff966FD6), // pastel deep purple
      Color(0xff8B4513), // pastel brown
      Color(0xffD1E231), // pastel lime
      Color(0xffE6E6FA), // pastel lavender
      Color(0xffD8BFD8), // pastel thistle
      Color(0xffBC8F8F), // pastel rosy brown
      Color(0xffF4A460), // pastel sandy brown
      Color(0xff66CDAA), // pastel medium aquamarine
      Color(0xffFFB6C1), // pastel light pink
      Color(0xffFFA07A), // pastel light salmon
      Color(0xff20B2AA), // pastel light sea green
      Color(0xff87CEFA), // pastel light sky blue
    ];

    int colorIndex = 0;
    return stats.entries.map((entry) {
      final genre = entry.key;
      final value = entry.value;
      colorIndex++;

      return BarChartGroupData(
        x: stats.keys.toList().indexOf(genre),
        barRods: [
          BarChartRodData(
            y: value.toDouble(),
            colors: [
              beige2,
              brown,
              lightBrown,
            ],
            width: 16,
          ),
        ],
      );
    }).toList();
  }
}
