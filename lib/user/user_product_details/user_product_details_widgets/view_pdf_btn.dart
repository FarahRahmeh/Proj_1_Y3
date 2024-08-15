import 'package:booktaste/common/features/books/book_pdf_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/book/pdf_controlller.dart';
import '../../../utils/constans/api_constans.dart';

class BookActionBtn extends StatelessWidget {
  final String bookUrl;
  const BookActionBtn({super.key, required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    final pdfCtrl = Get.put(PdfController());
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            // onTap: () async {
            //   await pdfCtrl.fetchPdf('$baseImageUrl$bookUrl');
            //   Get.to(() => BookPdfViewerPage(pdfUrl: pdfCtrl.pdfPath.value));
            // },
            // onTap: () async {
            //   await pdfCtrl.openFile(url: '$baseImageUrl$bookUrl');
            // },
            // onTap: () async {
            //   Get.to(() => BookPdfViewerPage(
            //         pdfUrl: bookUrl,
            //       ));
            // },
            child: Row(
              children: [
                SizedBox(width: 10),
                Text(
                  "READ BOOK",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        letterSpacing: 1.2,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
