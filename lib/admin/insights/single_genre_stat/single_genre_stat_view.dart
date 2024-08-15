import 'package:booktaste/admin/insights/single_genre_stat/single_genre_stat_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShelfStatPage extends StatelessWidget {
  ShelfStatPage({Key? key, this.id}) : super(key: key);
  final id;
  final statsCtrl = Get.put(ShelfStatsController());

  @override
  Widget build(BuildContext context) {
    statsCtrl.fetchShelfStat(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shelf Statistics'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: MyDropdownBtnFormField(
          //     items: List.generate(30, (int index) => (index + 1).toString(),
          //         growable: false), // Assuming these are shelf IDs
          //     onChanged: (String? newValue) {
          //       if (newValue != null) {
          //         statsCtrl.fetchShelfStat(newValue);
          //       }
          //     },
          //   ),
          // ),
          Expanded(
            child: Obx(() {
              if (statsCtrl.isStatsLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                // Example: Assuming shelfStat is a percentage value
                return Padding(
                  padding: EdgeInsets.all(Sizes.md),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display circular indicator with percentage
                      Center(
                        child: CircularIndicatorWithPercentage(
                          percentage: statsCtrl.shelfStat.value.toDouble(),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class CircularIndicatorWithPercentage extends StatelessWidget {
  final double percentage; // This should be between 0 and 100

  CircularIndicatorWithPercentage({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, // Adjust size as needed
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            strokeAlign: 10,
            value: percentage / 100,
            strokeWidth: 10,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(lightBrown),
          ),
          // Percentage text
          Text(
            '${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:booktaste/admin/insights/genres_statistics/genres_stats_controller.dart';
// import 'package:booktaste/admin/insights/single_genre_stat/single_genre_stat_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ShelfStatPage extends StatelessWidget {
//   final statsCtrl = Get.put(ShelfStatsController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shelf Statistics'),
//       ),
//       body: Obx(() {
//         if (statsCtrl.isStatsLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         } else {
//           return ListView.builder(
//             itemCount: 30,
//             itemBuilder: (context, index) {
//               final shelfId = (index + 1).toString();
//               final percentage = statsCtrl.shelfStats[shelfId] ?? 0;

//               return ListTile(
//                 title: Text('Shelf $shelfId'),
//                 trailing: CircularIndicatorWithPercentage(
//                   percentage: percentage.toDouble(),
//                 ),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }

// class CircularIndicatorWithPercentage extends StatelessWidget {
//   final double percentage; // This should be between 0 and 100

//   CircularIndicatorWithPercentage({required this.percentage});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 50, // Adjust size as needed
//       height: 50,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           CircularProgressIndicator(
//             value: percentage / 100,
//             strokeWidth: 4.0,
//             backgroundColor: Colors.grey[200],
//             valueColor: AlwaysStoppedAnimation<Color>(
//                 Colors.blue), // Change color as needed
//           ),
//           Text(
//             '${percentage.toStringAsFixed(0)}%',
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: Colors.black, // Change color as needed
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
