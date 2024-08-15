import 'dart:convert';
import 'package:booktaste/user/user_statistics/monthly_insights/monthly_stat_model.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class MonthlyStatsController extends GetxController {
  var monthlyStats = <MonthlyStat>[].obs;
  var isLoading = false.obs;
  var currentMonthStats = MonthlyStat().obs;
  var otherMonthsStats = <MonthlyStat>[].obs;

  @override
  void onInit() {
    fetchMonthlyStats();
    super.onInit();
  }

  Future<void> fetchMonthlyStats() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/getMonthly'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );

      if (response.statusCode == 200) {
        print('monthly 200');
        List<dynamic> data = json.decode(response.body);
        monthlyStats.value =
            data.map((json) => MonthlyStat.fromJson(json)).toList();
        _filterStats();
        
      } else {
        print('monthly error');
        Get.snackbar('Error', 'Failed to fetch monthly stats');
      }
    } catch (e) {
      print('monthly catch');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _filterStats() {
    final int currentMonth = DateTime.now().month;

    currentMonthStats.value.month = currentMonth;

    otherMonthsStats.value =
        monthlyStats.where((stat) => stat.month != currentMonth).toList();
  }

  MonthlyStat getThisMontgActivity() {
    DateTime today = DateTime.now();
    return monthlyStats.firstWhere((stat) => stat.month! == today.month,
        orElse: () => MonthlyStat());
  }
}
