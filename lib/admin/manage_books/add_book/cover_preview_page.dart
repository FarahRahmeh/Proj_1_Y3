import 'dart:io';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CoverPreviewPage extends StatelessWidget {
  final String imagePath;

  const CoverPreviewPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Cover Preview'),
      ),
      body: PhotoView(
        imageProvider: FileImage(File(imagePath)),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
