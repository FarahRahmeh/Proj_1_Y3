import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/category/x_card.dart';
import 'package:booktaste/user/user_statistics/daily_insights/daily_stat_controller.dart';
import 'package:booktaste/user/user_statistics/daily_insights/other_days_view.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class DailyStatsView extends StatelessWidget {
  final statsCtrl = Get.put(DailyStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Today\'s Activity '),
        showBackArrow: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => OtherDaysView());
            },
            icon: Icon(
              Iconsax.calendar_copy,
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (statsCtrl.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (statsCtrl.dailyStats.isEmpty ||
            statsCtrl.dailyActivity.value.date == null) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    Images.insightsDaily1,
                    width: 260,
                    height: 260,
                  ),
                ),
                SizedBox(
                  height: Sizes.lg,
                ),
                Text(
                  'NO ACTIVITY FOR TODAY..',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTodayActivity(context),
                  const SizedBox(height: Sizes.md),
                  // _buildCharts(),
                  // const SizedBox(height: Sizes.md),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget _buildTodayActivity(BuildContext context) {
    final today = statsCtrl.dailyActivity.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: Sizes.sm),
              child: Icon(
                Iconsax.calendar_copy,
                size: Sizes.lg,
              ),
            ),
            Text(
              'Day : ${today.date!.year}/${today.date!.month}/${today.date?.day}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        // const SizedBox(height: Sizes.md),
        Center(
            child: Image.asset(
          Images.insightsDaily1,
          height: 300,
        )),
        const SizedBox(height: Sizes.md),
        XCard(
          title: '${today.totalReadPages} Pages!',
          borderColorLight: lightBrown.withOpacity(0.8),
          isImage: true,
          image: Images.bookPage,
          icon: Iconsax.book_1_copy,
          iconColor: lightBrown,
          backgroundColor: offWhite, // beige2.withOpacity(0.5),
          subTitle: '${today.totalReadPages} pages you have read today',
        ),
        const SizedBox(height: Sizes.sm),
        XCard(
          title: '${today.totalReadingTime} Time!',
          isImage: true,
          borderColorLight: pinkish.withOpacity(0.6),
          image: Images.fireTime,
          icon: Iconsax.timer_copy,
          iconColor: pinkish,
          backgroundColor: offWhite, // lightBrown.withOpacity(0.2),
          subTitle: '${today.totalReadingTime} time you spent today',
        ),
        const SizedBox(height: Sizes.sm),
        XCard(
          title:
              '${today.numOfSessions} Session${today.numOfSessions == 1 ? '' : 's'}!',
          isImage: true,
          borderColorLight: bluish.withOpacity(0.7),
          image: Images.session,
          icon: Iconsax.lamp_copy,
          iconColor: brown,
          backgroundColor: offWhite,
          subTitle:
              '${today.numOfSessions} session${today.numOfSessions == 1 ? '' : 's'} you achieved today',
        ),
      ],
    );
  }

  // Widget _buildCharts() {
  //   return Column(
  //     children: [
  //       Text(
  //         'Reading Time in Minutes',
  //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //       ),
  //       const SizedBox(height: Sizes.sm),
  //       SizedBox(
  //         height: 200,
  //         child: BarChart(
  //           BarChartData(
  //             barGroups: statsCtrl.getReadingTimeBars(),
  //             borderData: FlBorderData(show: false),
  //             titlesData: FlTitlesData(
  //               bottomTitles: SideTitles(
  //                 showTitles: true,
  //                 getTitles: (double value) {
  //                   int index = value.toInt();
  //                   if (index >= 0 && index < statsCtrl.dailyStats.length) {
  //                     return statsCtrl.dailyStats[index].date!.day.toString() +
  //                         '/' +
  //                         statsCtrl.dailyStats[index].date!.month.toString();
  //                   }
  //                   return '';
  //                 },
  //               ),
  //               leftTitles: SideTitles(
  //                 showTitles: true,
  //                 getTextStyles: (context, value) {
  //                   return const TextStyle(color: Colors.black, fontSize: 10);
  //                 },
  //               ),
  //               rightTitles: SideTitles(showTitles: false),
  //               topTitles: SideTitles(showTitles: false),
  //             ),
  //             barTouchData: BarTouchData(
  //               touchTooltipData: BarTouchTooltipData(
  //                 tooltipBgColor: Colors.grey,
  //                 getTooltipItem: (group, groupIndex, rod, rodIndex) {
  //                   String date =
  //                       '${statsCtrl.dailyStats[group.x.toInt()].date!.day}/${statsCtrl.dailyStats[group.x.toInt()].date!.month}/${statsCtrl.dailyStats[group.x.toInt()].date!.year}';
  //                   return BarTooltipItem(
  //                     '$date\n',
  //                     TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                     children: <TextSpan>[
  //                       TextSpan(
  //                         text: 'Reading Time: ${rod.y.round()} mins',
  //                         style: TextStyle(
  //                           color: Colors.yellow,
  //                         ),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
