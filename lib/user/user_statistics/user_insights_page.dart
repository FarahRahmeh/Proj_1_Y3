import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/user/user_statistics/daily_insights/daily_stat_view.dart';
import 'package:booktaste/user/user_statistics/genre_insights/genre_read_percent/genre_read_perc_view.dart';
import 'package:booktaste/user/user_statistics/genre_insights/genre_read_summary/genre_read_summary_view.dart';
import 'package:booktaste/user/user_statistics/monthly_insights/monthly_stat_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserInsightsPage extends StatelessWidget {
  const UserInsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Statistics'),
        showBackArrow: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => DailyStatsView()),
            icon: Icon(Iconsax.calendar_copy),
          ),
          IconButton(
            onPressed: () => Get.to(() => MonthlyStatsView()),
            icon: Icon(Iconsax.calendar_1_copy),
          ),
          IconButton(
            onPressed: () => Get.to(() => GenreReadPercentView()),
            icon: Icon(Iconsax.percentage_circle_copy),
          ),
          IconButton(
            onPressed: () => Get.to(() => GenreReadSummaryView()),
            icon: Icon(Iconsax.graph_copy),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
