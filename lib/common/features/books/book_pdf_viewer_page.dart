// // import 'package:booktaste/common/widgets/appbar/appbar.dart';
// // import 'package:booktaste/controllers/book/pdf_controlller.dart';
// // import 'package:booktaste/utils/constans/api_constans.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:iconsax_flutter/iconsax_flutter.dart';
// // import 'package:open_file/open_file.dart';
// // import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// // import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

// // class BookPdfViewerPage extends StatelessWidget {
// //   final String pdfUrl;

// //   BookPdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     print(
// //       Uri.parse(baseImageUrl).resolve(pdfUrl).toString(),
// //     );
// //     final pdfController = Get.put(PdfController());
// //     return Scaffold(
// //       appBar: MyAppBar(
// //         showBackArrow: true,
// //         title: Text('PDF Viewer'),
// //         // leadingIcon: Iconsax.book,
// //         // leadingOnPressed: () {
// //         //   pdfController.pdfViewerKey.currentState?.openBookmarkView();
// //         // },
// //       ),
// //       body: FutureBuilder<void>(
// //         future: Future.delayed(Duration(seconds: 4)),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(
// //               child: CircularProgressIndicator(),
// //             );
// //           } else {
// //             try {
// //               return PDF().cachedFromUrl('$baseImageUrl$pdfUrl',
// //                   key: pdfController.pdfViewerKey,
// //                   headers: {
// //                     'Connection': 'keep-alive',
// //                     'Accept-Encoding': 'gzip, deflate, br',
// //                     'content-type': 'application/pdf',
// //                   },
// //                   placeholder: (double progress) =>
// //                       Center(child: Text('$progress %')),
// //                   errorWidget: (dynamic error) {
// //                     print(error.toString());
// //                     return Center(child: Text(error.toString()));
// //                   });
// //             } catch (e) {
// //               return Center(child: Text(e.toString()));
// //             } finally {
// //               return Center(child: Text('connection failed'));
// //             }
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:booktaste/common/widgets/appbar/appbar.dart';
// import 'package:booktaste/controllers/book/pdf_controlller.dart';
// import 'package:booktaste/utils/constans/api_constans.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:open_file/open_file.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';

// class BookPdfViewerPage extends StatelessWidget {
//   final String pdfUrl;

//   BookPdfViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

//   Future<File?> _downloadPdf() async {
//     try {
//       // var request = http.Request(
//       //     'GET',
//       //     Uri.parse(
//       //       'http://10.0.2.2:8000/api/getBook/$pdfUrl',
//       //     ));
//       // request.headers.addAll({
//       //   'Connection': 'keep-alive',
//       //   'Accept-Encoding': 'gzip, deflate, br',
//       //   'Content-Type': 'application/pdf'
//       // });
//       // http.StreamedResponse response = await request.send();

//       // if (response.statusCode == 200) {
//       //   final bytes = await response.stream.toBytes();
//       //   final dir = await getApplicationDocumentsDirectory();
//       //   final file = File('${dir.path}/downloaded.pdf');
//       //   await file.writeAsBytes(bytes);
//       //   print('PDF downloaded successfully');
//       //   return file;
//       // } else {
//       //   print(response.reasonPhrase);
//       //   return null;
//       // }
//       final url = Uri.parse('http://10.0.2.2:8000/api/getBook/$pdfUrl');
//       print('http://10.0.2.2:8000/api/getBook/$pdfUrl');
//       final response = await http.get(url);
//       final bytes = response.bodyBytes;
//       final dir = await getApplicationDocumentsDirectory();
//       final file = File('${dir.path}/downloaded.pdf');
//       await file.writeAsBytes(bytes);
//       return file;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//     // finally {
//     //   print('Connetion closed');
//     // }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pdfController = Get.put(PdfController());
//     return Scaffold(
//       appBar: MyAppBar(
//         showBackArrow: true,
//         title: Text('PDF Viewer'),
//       ),
//       body: FutureBuilder<File?>(
//         future: _downloadPdf(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             final file = snapshot.data!;
//             return SfPdfViewer.file(file);
//             // return PDF().cachedFromFile(
//             //   file,
//             //   key: pdfController.pdfViewerKey,
//             //   headers: {
//             //     'Connection': 'keep-alive',
//             //     'Accept-Encoding': 'gzip, deflate, br',
//             //     'content-type': 'application/pdf',
//             //   },
//             //   placeholder: (double progress) =>
//             //       Center(child: Text('$progress %')),
//             //   errorWidget: (dynamic error) =>
//             //       Center(child: Text(error.toString())),
//             // );
//           } else {
//             return Center(
//               child: Text('Failed to load PDF'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_pdfview/flutter_pdfview.dart';
// // // import 'package:get/get.dart';

// // // class BookPdfViewerPage extends StatelessWidget {
// // //   final String pdfUrl;

// // //   BookPdfViewerPage({required this.pdfUrl});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('PDF Viewer'),
// // //       ),
// // //       body: PDFView(
// // //         filePath: pdfUrl,
// // //       ),
// // //     );
// // //   }
// // // }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
