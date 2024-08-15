import 'package:booktaste/user/user_product_details/PdfViewerPage.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class YourWidget extends GetxController {
  Future<String> downloadAndSaveFile(int id, String fileName) async {
    final response =
        await http.get(Uri.parse('${baseUrl}/getBook/$id'));
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, fileName);
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }
}
