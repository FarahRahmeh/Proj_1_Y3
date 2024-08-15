import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/circular_image.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:booktaste/user/user_statistics/monthly_insights/monthly_stat_model.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MonthlyCard extends StatelessWidget {
  final MonthlyStat monthlyStat;

  MonthlyCard({required this.monthlyStat});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      // showBorder: true,
      backgroundColor: lightBrown.withOpacity(0.5),
      margin: EdgeInsets.all(Sizes.sm),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.md),
        child: Column(
          children: [
            Text(
              'Month ${monthlyStat.month ?? 'N/A'} of ${monthlyStat.year ?? ''} Year',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: Sizes.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RoundedContainer(
                    padding: EdgeInsets.all(Sizes.sm),
                    backgroundColor: MyColors.white,
                    child: Column(
                      children: [
                        CircularImage(
                          image: Images.bookPage,
                          backgroundColor: offWhite,
                        ),
                        Text(
                          'Avg. Reading Pages ',
                          style: TextStyle(color: brown),
                        ),
                        Text(
                          '${monthlyStat.avgDailyReadPages!.toStringAsFixed(2)} ',
                          style: TextStyle(color: brown),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: Sizes.sm,
                ),
                Expanded(
                  child: RoundedContainer(
                    padding: EdgeInsets.all(Sizes.sm),
                    backgroundColor: MyColors.white,
                    child: Column(
                      children: [
                        CircularImage(
                          image: Images.time,
                          backgroundColor: offWhite,
                        ),
                        Text(
                          'Avg. Reading Time',
                          style: TextStyle(color: brown),
                        ),
                        Text(
                          '${monthlyStat.avgDailyReadTime ?? 'N/A'}',
                          style: TextStyle(color: brown),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Sizes.md),
            Row(
              children: [
                Expanded(
                  child: RoundedContainer(
                    padding: EdgeInsets.all(Sizes.sm),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: Sizes.sm),
                          child: Icon(
                            Iconsax.book_1_copy,
                            color: lightBrown,
                            size: 22,
                          ),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(text: 'Books\n'),
                        //       TextSpan(
                        //         text: '${monthlyStat.totalBooks ?? 'N/A'}',
                        //         style: TextStyle(
                        //           color: MyColors.darkGrey,
                        //           fontSize: 12,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Text(
                          'Books',
                          style: TextStyle(color: brown),
                        ),
                        Text(
                          '${monthlyStat.totalBooks ?? 'N/A'}',
                          style: TextStyle(
                            color: MyColors.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: Sizes.sm,
                ),
                // Container(
                //   width: 1,
                //   height: 70,
                //   color: lightBrown,
                // ),
                Expanded(
                  child: RoundedContainer(
                    padding: EdgeInsets.all(Sizes.sm),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: Sizes.sm),
                          child: Icon(
                            Iconsax.document_favorite_copy,
                            color: pinkish,
                            size: 22,
                          ),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(text: 'Pages\n'),
                        //       TextSpan(
                        //         text: '${monthlyStat.totalReadPages ?? 'N/A'}',
                        //         style: TextStyle(
                        //           color: MyColors.darkGrey,
                        //           fontSize: 12,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Text(
                          'Pages',
                          style: TextStyle(color: brown),
                        ),
                        Text(
                          '${monthlyStat.totalReadPages ?? 'N/A'}',
                          style: TextStyle(
                            color: MyColors.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: Sizes.sm,
                ),
                // Container(
                //   width: 1,
                //   height: 70,
                //   color: lightBrown,
                // ),
                Expanded(
                  child: RoundedContainer(
                    padding: EdgeInsets.all(Sizes.sm),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: Sizes.sm),
                          child: Icon(
                            Iconsax.timer_copy,
                            color: darkBrown,
                            size: 22,
                          ),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(text: 'Sessions\n'),
                        //       TextSpan(
                        //         text: '${monthlyStat.totalSessions ?? 'N/A'}',
                        //         style: TextStyle(
                        //           color: MyColors.darkGrey,
                        //           fontSize: 12,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Text(
                          'Sessions',
                          style: TextStyle(color: brown),
                        ),
                        Text(
                          '${monthlyStat.totalSessions ?? 'N/A'}',
                          style: TextStyle(
                            color: MyColors.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: Sizes.sm,
                ),
                // Container(
                //   width: 1,
                //   height: 70,
                //   color: lightBrown,
                // ),
                Expanded(
                  child: RoundedContainer(
                    padding: EdgeInsets.all(Sizes.sm),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: Sizes.sm),
                          child: Icon(
                            Iconsax.clock_copy,
                            color: bluish,
                            size: 22,
                          ),
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(text: 'Time\n'),
                        //       TextSpan(
                        //         text:
                        //             '${monthlyStat.totalReadingTime ?? 'N/A'}',
                        //         style: TextStyle(
                        //           color: MyColors.darkGrey,
                        //           fontSize: 12,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Text(
                          'Time',
                          style: TextStyle(color: brown),
                        ),
                        Text(
                          '${monthlyStat.totalReadingTime ?? 'N/A'}',
                          style: TextStyle(
                            color: MyColors.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Expanded(
            //       child: Row(
            //         children: [
            //           Expanded(child: XCard()),
            //           Expanded(child: XCard()),
            //         ],
            //       ),
            //     ),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: [],
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 16),
            // Text(
            //   'Month: ${monthlyStat.month ?? 'N/A'} ${monthlyStat.year ?? ''}',
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            // SizedBox(height: 8),
            // Text('Total Read Pages: ${monthlyStat.totalReadPages ?? 0}'),
            // Text(
            //     'Total Reading Time: ${monthlyStat.totalReadingTime ?? 'N/A'}'),
            // Text(
            //     'Average Daily Read Pages: ${monthlyStat.avgDailyReadPages?.toStringAsFixed(2) ?? 'N/A'}'),
            // Text(
            //     'Average Daily Read Time: ${monthlyStat.avgDailyReadTime ?? 'N/A'}'),
            // Text('Total Sessions: ${monthlyStat.totalSessions ?? 0}'),
            // Text('Total Books: ${monthlyStat.totalBooks ?? 0}'),
            if (monthlyStat.lastActivityDate != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Last Activity Date:',
                  ),
                  Text(
                    ' ${monthlyStat.lastActivityDate!.toLocal().toString().split(' ')[0]}',
                    style: TextStyle(
                      color: dark ? lightBrown : darkBrown,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
