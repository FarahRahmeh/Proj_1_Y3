import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/circular_container.dart';
import 'package:booktaste/user/user_statistics/genre_insights/genre_read_summary/genre_read_summ_controller.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../common/widgets/dropdown_button_form_field/my_dorpdown_btn_form_field.dart';

class GenreReadSummaryView extends StatelessWidget {
  final statsCtrl = Get.put(GenreReadSummaryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Shelf Summary Statistics'),
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
                  statsCtrl.fetchShelfReadSummary(newValue);
                }
              },
            ),
            SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            Expanded(
              child: Obx(() {
                if (statsCtrl.isGRSLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  var pieChartData =
                      getPieChartSections(statsCtrl.shelfReadSummary);
                  var pieChartSections = pieChartData['sections'];
                  var colorMapping = pieChartData['colorMapping'];

                  return Column(
                    children: [
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            sections: pieChartSections,
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                            borderData: FlBorderData(show: false),
                            pieTouchData: PieTouchData(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ListView.builder(
                          itemCount: statsCtrl.shelfReadSummary.length,
                          itemBuilder: (context, index) {
                            String key = statsCtrl.shelfReadSummary.keys
                                .elementAt(index);
                            String value =
                                statsCtrl.shelfReadSummary[key]!.toString();

                            Color tileColor = colorMapping[key];

                            return ListTile(
                              title: Text(key),
                              trailing: Text(value.toString().length > 5
                                  ? value.toString().substring(0, 4) + '%'
                                  : value.toString() + '%'),
                              leading: CircularContainer(
                                backgroundColor: tileColor,
                                width: 15,
                                height: 15,
                              ),
                              // tileColor: tileColor, // Set the tile color
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

  Map<String, dynamic> getPieChartSections(Map<String, double> stats) {
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
    Map<String, Color> colorMapping = {};

    List<PieChartSectionData> sections = stats.entries.map((entry) {
      final isZero = entry.value == 0;
      final color = colors[colorIndex % colors.length];
      colorMapping[entry.key] = color; // Map each genre to its color
      colorIndex++;

      return PieChartSectionData(
        color: color.withOpacity(isZero ? 0.2 : 1),
        value: entry.value,
        title: isZero ? '' : entry.value.toString().substring(0, 4) + '%',
        radius: isZero ? 10 : 50,
        titleStyle: TextStyle(
          fontSize: isZero ? 10 : 16,
          fontWeight: isZero ? FontWeight.normal : FontWeight.bold,
          color: isZero ? Colors.black54 : Colors.white,
        ),
      );
    }).toList();

    return {'sections': sections, 'colorMapping': colorMapping};
  }
}
