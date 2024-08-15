import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../utils/constans/api_constans.dart';

class PdfViewerPage extends StatefulWidget {
  final String pdfPath;
  final String bookId;

  PdfViewerPage({required this.pdfPath, required this.bookId});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  int currentPage = 0;
  int totalPages = 0;
  DateTime? startTime;
  DateTime? endTime;


  @override
  void initState() {
    super.initState();
    startTime = DateTime.now(); // تسجيل وقت بداية القراءة
    loadLastPage();
    _loadLastSession();
  }

  void loadLastPage() {
    final storage = GetStorage();
    currentPage = storage.read('book_${widget.bookId}_lastPage') ?? 0;
  }

  void saveLastPage() {
    final storage = GetStorage();
    storage.write('book_${widget.bookId}_lastPage', currentPage);
  }

  void saveReadingSession() async {
    endTime = DateTime.now(); // تسجيل وقت نهاية القراءة

    // تكوين الـ URL مع معرّف الكتاب فقط
    final url = '${baseUrl}/progress/${widget.bookId}';

    // تكوين جسم الطلب (Body) مع البيانات الأخرى
    final body = jsonEncode({
      'current_page': currentPage,
      'start_time': DateFormat('HH:mm:ss').format(startTime!),
      'end_time': DateFormat('HH:mm:ss').format(endTime!),
    });

    try {
      // إرسال الطلب إلى الخادم
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('Reading session saved successfully');
        print(response.body);
      } else {
        print('Failed to save reading session');
      }
    } catch (e) {
      print('Error occurred while saving reading session: $e');
    }
  }



  @override
  void dispose() {
    saveLastPage(); // حفظ الصفحة الأخيرة التي توقف عندها المستخدم
    saveReadingSession(); // حفظ جلسة القراءة
    super.dispose();
  }


  Future<void> _loadLastSession() async {
    try {
      // استرجاع آخر جلسة قراءة من السيرفر
      final response = await http.get(
        Uri.parse('${baseUrl}/lastProgress/${widget.bookId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          currentPage = data['current_page']; // استرجاع الصفحة الحالية من البيانات
        });
      } else {
        print('Failed to load last reading session: ${response.body}');
      }
    } catch (e) {
      print('Error loading last reading session: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: currentPage != null 
      ?PDFView(
        filePath: widget.pdfPath,
        defaultPage: currentPage!,
        onRender: (pages) {
          setState(() {
            totalPages = pages!;
          });
        },
        onViewCreated: (PDFViewController pdfViewController) {
          pdfViewController.setPage(currentPage);
        },
        onPageChanged: (page, total) {
          setState(() {
            currentPage = page!;
          });
        },
      )
       : Center(child: CircularProgressIndicator()),
    );
  }
}
