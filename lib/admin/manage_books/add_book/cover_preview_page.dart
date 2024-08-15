import 'dart:io';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CoverPreviewPage extends StatelessWidget {
  final String imagePath;
  final bool isAsset;
  const CoverPreviewPage(
      {Key? key, required this.imagePath, this.isAsset = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Cover Preview'),
        showBackArrow: true,
      ),
      body: PhotoView(
        imageProvider: isAsset
            ? AssetImage(imagePath) as ImageProvider
            : FileImage(File(imagePath)),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
      ),
    );
  }
}
