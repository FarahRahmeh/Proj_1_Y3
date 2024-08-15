// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

// class PdfController extends GetxController {
//   final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();

//   Future<void> openFile({required String url, String? fileName}) async {
//     print('Starting file download...');
//     final name = fileName ?? url.split('/').last;
//     final file = await downloadFile(url, name);
//     if (file == null) {
//       print('File download failed');
//       return;
//     }
//     print('File downloaded to path: ${file.path}');
//     OpenFile.open(file.path);
//   }

//   Future<File?> downloadFile(String url, String name) async {
//     final appStorage = await getApplicationDocumentsDirectory();
//     final file = File('${appStorage.path}/$name');
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Accept': '*/*',
//           'Connection': 'keep-alive',
//           'Accept-Encoding': 'gzip, deflate, br',
//           'Content-Type': 'application/pdf',
//         },
//       );
//       if (response.statusCode == 200) {
//         final raf = file.openSync(mode: FileMode.write);
//         raf.writeFromSync(response.bodyBytes);
//         await raf.close();
//         return file;
//       } else {
//         print(
//             'Error: Server responded with status code ${response.statusCode}');
//         return null;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return null;
//     }
//   }
// }
// // import 'package:get/get.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:io';
// // import 'package:path_provider/path_provider.dart';

// // class PdfController extends GetxController {
// //   var pdfPath = ''.obs;

// //   Future<void> fetchPdf(String url) async {
// //     try {
// //       final response = await http.get(Uri.parse(url));
// //       if (response.statusCode == 200) {
// //         final bytes = response.bodyBytes;
// //         final dir = await getApplicationDocumentsDirectory();
// //         final file = File('${dir.path}/temp.pdf');
// //         await file.writeAsBytes(bytes);
// //         pdfPath.value = file.path;
// //       } else {
// //         throw Exception('Failed to load PDF');
// //       }
// //     } catch (e) {
// //       print(e);
// //       throw Exception('Error fetching PDF');
// //     }
// //   }
// // }
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class PdfController extends GetxController {
  Future<void> downloadAndOpenPdf(String url, String fileName) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final filePath = "${dir.path}/$fileName";

      final response = await http.get(Uri.parse(url), headers: {
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Content-Type': 'application/pdf',
      });

      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        OpenFile.open(filePath);
      } else {
        throw Exception('Failed to download file');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to download or open file $e ');
      print(e);
    }
  }
}
