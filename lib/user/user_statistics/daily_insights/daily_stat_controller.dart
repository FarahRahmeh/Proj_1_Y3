import 'dart:convert';
import 'package:booktaste/user/user_statistics/daily_insights/daily_stat_model.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class DailyStatsController extends GetxController {
  var dailyStats = <DailyStat>[].obs;
  var isLoading = false.obs;
  var dailyActivity = DailyStat().obs;

  @override
  void onInit() {
    fetchDailyStats();
    super.onInit();
  }

  Future<void> fetchDailyStats() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/getDaily'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        dailyStats.value =
            jsonResponse.map((data) => DailyStat.fromJson(data)).toList();
        dailyActivity.value = getTodayActivity();
      } else {
        Get.snackbar('Error', 'Failed to fetch daily statistics');
        print('Failed to fetch daily statistics: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print('Error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  DailyStat getTodayActivity() {
    DateTime today = DateTime.now();
    return dailyStats.firstWhere(
        (stat) =>
            stat.date!.year == today.year &&
            stat.date!.month == today.month &&
            stat.date!.day == today.day,
        orElse: () => DailyStat());
  }

  List<FlSpot> getPagesReadSpots() {
    return dailyStats.map((stat) {
      double daysDifference =
          DateTime.now().difference(stat.date!).inDays.toDouble();
      double totalReadPages = stat.totalReadPages!.toDouble();

      if (daysDifference.isNaN ||
          daysDifference.isInfinite ||
          totalReadPages.isNaN ||
          totalReadPages.isInfinite) {
        return FlSpot(0, 0);
      }

      return FlSpot(daysDifference, totalReadPages);
    }).toList();
  }

  List<BarChartGroupData> getReadingTimeBars() {
    return dailyStats.map((stat) {
      double readingTimeInMinutes = stat.totalReadingTimeInMinutes();
      int daysDifference = DateTime.now().difference(stat.date!).inDays;
      print(daysDifference.toString() + 'diffrence');

      if (readingTimeInMinutes.isNaN || readingTimeInMinutes.isInfinite) {
        return BarChartGroupData(x: daysDifference, barRods: [
          BarChartRodData(y: 0, colors: [gray])
        ]);
      }

      return BarChartGroupData(
        x: daysDifference,
        barRods: [
          BarChartRodData(y: readingTimeInMinutes, colors: [lightBrown])
        ],
      );
    }).toList();
  }
}

// Helper function in DailyStat model to convert total reading time to minutes
extension on DailyStat {
  double totalReadingTimeInMinutes() {
    if (totalReadingTime == null || totalReadingTime!.isEmpty) {
      return 0.0;
    }
    List<String> parts = totalReadingTime!.split(':');
    if (parts.length != 3) {
      return 0.0;
    }
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return (hours * 60 + minutes + seconds / 60).toDouble();
  }
}
