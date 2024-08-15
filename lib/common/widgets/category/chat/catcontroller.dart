import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatController extends GetxController {
  var messages = <Message>[].obs;
  var isLoading = true.obs;
  var messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> fetchMessages(String catId) async {
    isLoading(true);
    final response = await http.get(Uri.parse('$baseUrl/getMessages/$catId'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      messages.value = data.map((item) => Message.fromJson(item)).toList();
      scrollToBottom();
    } else {
      Get.snackbar('Error', 'Failed to load messages');
    }
    isLoading(false);
  }

  Future<void> sendMessage(String message, String catId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sendMessage/$catId'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
      },
      body: {
        'message': message,
      },
    );

    if (response.statusCode == 200) {
      var data = response.body;
      messages.add(Message(
        message: message,
        createdAt: DateTime.now(),
        // استبدل هذا باسم المستخدم الحقيقي
        // userImage: 'assets/user_image.png', // استبدل هذا بمسار صورة المستخدم
      ));
      messageController.clear();
      scrollToBottom();
    } else {
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}

class Message {
  final String message;
  final DateTime createdAt;
  final String? userName;
  // final String userImage;

  Message({
    required this.message,
    required this.createdAt,
     this.userName,
    // required this.userImage,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      userName: json['user_name'], // تأكد من وجود حقل اسم المستخدم في JSON
      // userImage: json['profile_photo'], // تأكد من وجود حقل صورة المستخدم في JSON
    );
  }
}
