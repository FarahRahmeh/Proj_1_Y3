// inquiry_view.dart
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/inquiry/inquiry_controller.dart';

class UserInquiriesPage extends StatelessWidget {
  UserInquiriesPage({
    super.key,
  });
  final controller = Get.put(InquiryController());

  @override
  Widget build(BuildContext context) {
    controller.fetchUserInquiries();
    return Scaffold(
      appBar: MyAppBar(
        title: Text('My Inquiries'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (controller.isUserInqLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.userInquiriesList.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Text(
                  'No Inquiries on this book yet..',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Center(child: Image.asset(Images.quoteCoffee)),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.userInquiriesList.length,
          itemBuilder: (context, index) {
            final inquiry = controller.userInquiriesList[index];
            return ListTile(
              title: Text(inquiry.inquiry.toString()),
              subtitle: Text(inquiry.reply?.toString() ?? 'No Reply yet'),
              trailing: Text(
                inquiry.createdAt.toString().substring(0, 16),
              ),
            );
          },
        );
      }),
    );
  }
}
