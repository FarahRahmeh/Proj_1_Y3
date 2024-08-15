// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'dart:io';

// class PdfController extends GetxController {
//   Future<void> downloadAndOpenPdf(String url, String fileName) async {
//     try {
//       final dir = await getApplicationDocumentsDirectory();
//       final filePath = "${dir.path}/$fileName";

//       final response = await http.get(Uri.parse(url), headers: {
//         'Accept': '*/*',
//         'Connection': 'keep-alive',
//         'Accept-Encoding': 'gzip, deflate, br',
//         'Content-Type': 'application/pdf',
//       });

//       if (response.statusCode == 200) {
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         OpenFile.open(filePath);
//       } else {
//         throw Exception('Failed to download file');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to download or open file $e ');
//       print(e);
//     }
//   }
// }