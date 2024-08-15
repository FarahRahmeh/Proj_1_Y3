import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/user/user_statistics/monthly_insights/monthly_card.dart';
import 'package:booktaste/user/user_statistics/monthly_insights/monthly_stat_controller.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MonthlyStatsView extends StatelessWidget {
  final statsCtrl = Get.put(MonthlyStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Monthly Statistics'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (statsCtrl.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (statsCtrl.monthlyStats.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return SingleChildScrollView(
              padding: const EdgeInsets.all(Sizes.sm),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      Images.insightsMonthly1,
                      width: 180,
                      height: 180,
                    ),
                  ),
                  SizedBox(height: Sizes.sm),
                  SizedBox(
                    height: 500,
                    child: ListView.builder(
                      itemCount: statsCtrl.monthlyStats.length,
                      itemBuilder: (context, index) {
                        final stat = statsCtrl.monthlyStats[index];
                        return MonthlyCard(monthlyStat: stat);
                      },
                    ),
                  ),

                  // Bar Chart for Total Read Pages
                  // SizedBox(
                  //   height: 300,
                  //   child: BarChart(
                  //     BarChartData(
                  //       titlesData: FlTitlesData(show: true),
                  //       borderData: FlBorderData(show: false),
                  //       barGroups: statsCtrl.monthlyStats
                  //           .map(
                  //             (stat) => BarChartGroupData(
                  //               x: stat.month!.toInt(),
                  //               barRods: [
                  //                 BarChartRodData(
                  //                   y: stat.totalReadPages!.toDouble(),
                  //                   colors: [Colors.blue],
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //           .toList(),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // // Line Chart for Total Reading Time
                  // // SizedBox(
                  // //   height: 300,
                  // //   child: LineChart(
                  // //     LineChartData(
                  // //       titlesData: FlTitlesData(show: true),
                  // //       borderData: FlBorderData(show: false),
                  // //       lineBarsData: [
                  // //         LineChartBarData(
                  // //           spots: statsCtrl.monthlyStats
                  // //               .map(
                  // //                 (stat) => FlSpot(
                  // //                   stat.month!.toDouble(),
                  // //                   _parseTimeToHours(
                  // //                       stat.totalReadingTime.toString()),
                  // //                 ),
                  // //               )
                  // //               .toList(),
                  // //           isCurved: true,
                  // //           colors: [Colors.green],
                  // //           barWidth: 4,
                  // //         ),
                  // //       ],
                  // //     ),
                  // //   ),
                  // // ),
                  // SizedBox(height: 20),
                  // // Pie Chart for Number of Sessions
                  // SizedBox(
                  //   height: 300,
                  //   child: PieChart(
                  //     PieChartData(
                  //       sections: statsCtrl.monthlyStats
                  //           .map(
                  //             (stat) => PieChartSectionData(
                  //               value: stat.totalSessions!.toDouble(),
                  //               title: '${stat.totalSessions}',
                  //               color: Colors.primaries[
                  //                   stat.month! % Colors.primaries.length],
                  //               radius: 50,
                  //             ),
                  //           )
                  //           .toList(),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 20),
                  // // Bar Chart for Total Books
                  // SizedBox(
                  //   height: 300,
                  //   child: BarChart(
                  //     BarChartData(
                  //       titlesData: FlTitlesData(show: true),
                  //       borderData: FlBorderData(show: false),
                  //       barGroups: statsCtrl.monthlyStats
                  //           .map(
                  //             (stat) => BarChartGroupData(
                  //               x: stat.month!.toInt(),
                  //               barRods: [
                  //                 BarChartRodData(
                  //                   y: stat.totalBooks == 0
                  //                       ? 1
                  //                       : stat.totalBooks!.toDouble(),
                  //                   colors: [Colors.purple],
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //           .toList(),
                  //     ),
                  //   ),
                  // ),
                ],
              ));
        }
      }),
    );
  }

  double _parseTimeToHours(String time) {
    List<String> parts = time.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return hours + (minutes / 60) + (seconds / 3600);
  }
}
