import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/user/user_statistics/daily_insights/daily_stat_controller.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import 'daily_stat_model.dart';

class OtherDaysView extends StatelessWidget {
  OtherDaysView({super.key});
  final statsCtrl = Get.put(DailyStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Other Days\' Activities'),
        showBackArrow: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Center(
                  child: Image.asset(
                Images.insightsDaily1,
                height: 200,
              )),
              const SizedBox(height: Sizes.sm),
              SizedBox(
                width: 300,
                height: 300,
                child: ListView.builder(
                  itemCount: statsCtrl.dailyStats
                      .where((stat) =>
                          stat.date != statsCtrl.dailyActivity.value.date)
                      .length,
                  itemBuilder: (context, index) {
                    DailyStat stat = statsCtrl.dailyStats
                        .where((stat) =>
                            stat.date != statsCtrl.dailyActivity.value.date)
                        .elementAt(index);
                    return Column(
                      children: [
                        RoundedContainer(
                          backgroundColor: lightBrown.withOpacity(0.5),
                          child: ListTile(
                            trailing: Icon(Iconsax.calendar_2_copy),
                            // tileColor: lightBrown.withOpacity(0.5),
                            title: Text(
                                'Date: ${stat.date!.year}/${stat.date!.month}/${stat.date!.day}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Total Read Pages: ${stat.totalReadPages}'),
                                Text(
                                    'Total Reading Time: ${stat.totalReadingTime}'),
                                Text(
                                    'Number of Sessions: ${stat.numOfSessions}'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Sizes.md,
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
