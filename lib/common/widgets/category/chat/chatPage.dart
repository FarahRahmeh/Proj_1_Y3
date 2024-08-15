import 'package:booktaste/common/widgets/category/chat/catcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:math'; // لإستخدام Random لاختيار اللون العشوائي

class ChatPage extends StatelessWidget {
  final String catId;

  ChatPage({required this.catId});

  final List<Color> colors = [
    Color(0xff2E2E2E), // Dark Gray
    Color(0xff3B3B3B), // Dim Gray
    Color(0xff4B0082), // Indigo
    Color(0xff2F4F4F), // Dark Slate Gray
    Color(0xff556B2F), // Dark Olive Green
    Color(0xff8B0000), // Dark Red
    Color(0xff483D8B), // Dark Slate Blue
    Color(0xff2C3E50), // Midnight Blue
    Color(0xff7B241C), // Firebrick
    Color(0xff1C2833), // Very Dark Blue
    Color(0xff512E5F), // Dark Purple
    Color(0xff154360), // Dark Blue
    Color(0xff145A32), // Dark Green
    Color(0xff7D6608), // Dark Goldenrod
    Color(0xff4A235A), // Dark Magenta
    Color(0xff641E16), // Maroon
    Color(0xff1B2631), // Dark Slate
    Color(0xff17202A), // Very Dark Gray
    Color(0xff0B5345), // Dark Teal
    Color(0xff7E5109), // Saddle Brown
  ];

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());

    chatController.fetchMessages(catId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Obx(() {
        if (chatController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: () => chatController.fetchMessages(catId),
            child: ListView.builder(
              controller: chatController.scrollController,
              itemCount: chatController.messages.length,
              itemBuilder: (context, index) {
                final message = chatController.messages[index];

                // اختيار لون عشوائي لاسم المستخدم
                final randomColor = colors[Random().nextInt(colors.length)];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Icon(
                                          Iconsax.user,
                                          size: 15,
                                          color:
                                              randomColor, // تطبيق اللون العشوائي
                                        ),
                                      ),
                                      Text(
                                        chatController.messages[index].userName
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color:
                                              randomColor, // تطبيق اللون العشوائي
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    message.createdAt
                                        .toString()
                                        .substring(0, 16),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Text(
                                message.message,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      }),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: chatController.messageController,
                decoration: InputDecoration(hintText: 'Enter your message'),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                chatController.sendMessage(
                  chatController.messageController.text,
                  catId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
