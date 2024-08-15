import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/controllers/contact_us/contact_us_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactDetailsPage extends StatelessWidget {
  final String id;

  ContactDetailsPage({required this.id});

  final controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact Us Message Details")),
      body: FutureBuilder<ContactUs?>(
        future: controller.fetchContactDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || snapshot.data == null) {
            return Center(child: Text("Failed to load details."));
          } else {
            final details = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("From : ${details.email}",
                      style: TextStyle(fontSize: 24)),
                  Text("User Name : ${details.userName}",
                      style: TextStyle(fontSize: 20)),
                  Text(
                      "Date : ${details.createdAt!.year.toString() + ' - ' + details.createdAt!.month.toString() + ' - ' + details.createdAt!.day.toString()}",
                      style: TextStyle(fontSize: 18)),
                  Text("Message: ${details.message ?? 'Unknown'}",
                      style: TextStyle(fontSize: 18)),
                  Text("Reply by: ${details.reply ?? 'No Replier'}",
                      style: TextStyle(fontSize: 18)),
                  Text("Reply: ${details.reply ?? 'No Reply'}",
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
