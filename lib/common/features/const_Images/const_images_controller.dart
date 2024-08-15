import 'package:booktaste/utils/constans/images.dart';
import 'package:get/get.dart';

class ConstImagesController extends GetxController {
  var selectedImage = ''.obs;

  // List of image paths
  final List<String> imageCoversList = [
    Images.cover1,
    Images.cover2,
    Images.cover3,
  ];

  List<String> journalCovers = [
    Images.quotebook1,
    Images.quotebook2,
    Images.quotebook3,
    Images.quotebook4,
    Images.quotebook5,
    Images.quotebook6,
    Images.quotebook7,
    Images.quotebook8,
    Images.quotebook9,
    Images.quotebook10,
    Images.quotebook11,
    Images.quotebook12,
    Images.quotebook13,
    Images.quotebook14,
  ];

  final Map<String, String> imagePathMap = {
    'quotebook1': 'assets/images/quoteBooks/quotebook1.jpg',
    'quotebook2': 'assets/images/quoteBooks/quotebook2.jpg',
    'quotebook3': 'assets/images/quoteBooks/quotebook3.jpg',
    'quotebook4': 'assets/images/quoteBooks/quotebook4.jpg',
    'quotebook5': 'assets/images/quoteBooks/quotebook5.jpg',
    'quotebook6': 'assets/images/quoteBooks/quotebook6.jpg',
    'quotebook7': 'assets/images/quoteBooks/quotebook7.jpg',
  };

  void selectImage(String imagePath) {
    if (selectedImage.value == imagePath) {
      selectedImage.value = ''; // Deselect if already selected
    } else {
      selectedImage.value = imagePath; // Select new image
    }
  }

  bool isSelected(String img) {
    return selectedImage.value == img;
  }
  // void selectImage(String imagePath) {
  //   String assetPath = imagePathMap[imagePath] ?? '';
  //   if (selectedImage.value == assetPath) {
  //     selectedImage.value = ''; // Deselect if already selected
  //   } else {
  //     selectedImage.value = assetPath; // Select new image
  //   }
  // }

  // bool isSelected(String img) {
  //   String assetPath = imagePathMap[img] ?? '';
  //   return selectedImage.value == assetPath;
  // }
}
