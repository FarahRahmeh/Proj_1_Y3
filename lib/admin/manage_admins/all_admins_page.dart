import 'package:booktaste/admin/manage_admins/manage_admins_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAdminsPage extends StatelessWidget {
  AllAdminsPage({super.key});
  final adminsCtrl = Get.put(ManageAdminsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Admins'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (adminsCtrl.isAdminsLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: adminsCtrl.fetchAdmins,
            child: adminsCtrl.adminList.isEmpty
                ? Center(child: Text('No Admins yet!'))
                : ListView.builder(
                    itemCount: adminsCtrl.adminList.length,
                    itemBuilder: (context, index) {
                      final admin = adminsCtrl.adminList[index];
                      return ListTile(
                        title: Text(admin.name ?? 'No Name'),
                        subtitle: Text(admin.email ?? 'No Email'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            MyDialogs.defaultDialog(
                              context: context,
                              title: 'Delete Admin',
                              content: Text(
                                'Are you sure you want to delete this Admin forever?\n',
                              ),
                              cancelText: 'Cancel',
                              confirmText: 'Delete',
                              onCancel: () => Get.back(),
                              onConfirm: () {
                                adminsCtrl.removeAdmin(admin.id!);
                                Get.back();
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
        }
      }),
    );
  }
}
