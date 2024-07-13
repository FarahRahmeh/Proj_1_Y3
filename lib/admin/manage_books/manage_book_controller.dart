import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/popups/loaders.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ManageBookController extends GetxController {
  // Variables book
  final isNovel = false.obs;
  var isApproved;

  final isLocked = false.obs;
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final pubYearController = TextEditingController();
  final pointsController = TextEditingController();
  final pagesController = TextEditingController();
  final summaryController = TextEditingController();
  final localStorage = GetStorage();

  GlobalKey<FormState> addBookFormKey = GlobalKey<FormState>();

  //Genres
  var selecedGenres = <String>[].obs;
  List<String> genres = [
    'Fantasy',
    'Romance',
    'Poetry',
    'Drama',
    'Literature',
    'Fairy Tales & Folklore',
    'Mystery',
    'Thriller',
    'Horror',
    'Adventure',
    'Crime',
    'Comics',
    'Manga',
    'Humor',
    'Science Fiction',
    'Science',
    'Technology',
    'Travel',
    'Religion',
    'History',
    'Philosophy',
    'Psychology',
    'Life Stories',
    'Health',
    'Business',
    'Self-Help',
    'Education',
    'Children’s Literature',
    'Picture Book',
    'Young Adult',
  ];

  // // summary
  // //var summaryMaxLines = 1.obs;
  //// void updateSummaryMaxLines(String text) {
  //  // int lines = (text.length / 30).ceil();
  //   //if (lines <= 10) {
  //  //   summaryMaxLines.value = lines;
  ////   }
  //// }

  //!Image Variables
  final isImageUploading = false.obs;
  final imageUrl = Images.defaultBookCover.obs;

  //!File Varicables
  final pdfUrl = "".obs;
  final isPdfUploading = false.obs;



  //~ Methods
  //~ strill need fixing these two following
  @override
  void onInit() {
    setIsApproved();
    clearFields();
    super.onInit();
  }

  void clearFields() {
    titleController.clear();
    authorController.clear();
    pubYearController.clear();
    pointsController.clear();
    pagesController.clear();
    imageUrl.value = Images.defaultBookCover;
  }

  //! Genres Handling
  void addGenre(String genre) {
    if (!selecedGenres.contains(genre)) {
      selecedGenres.add(genre);
    }
  }

  void removeGenre(String genre) {
    if (selecedGenres.contains(genre)) {
      selecedGenres.remove(genre);
    }
  }

//! is Approved Handling
  void setIsApproved() {
    var role = GetStorage().read('ROLE');
    if (role == 'admin' || role == 'master_admin') {
      isApproved = true;
    } else {
      isApproved = false;
    }
    print(role + ' is approved ' + isApproved.toString());
  }

  //! image handling
  void pickImage() async {
    isImageUploading.value = true;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        print(image.path);
        // Upload image and get URL
        // final uploadService = Get.put(UploadService());
        // final url = await uploadService.uploadImage(File(image.path));
        imageUrl.value = image.path;
      }
    } catch (e) {
      Loaders.errorSnackBAr(title: 'error', message: e.toString());
      print("Image upload error: $e");
    } finally {
      isImageUploading.value = false;
    }
  }

  // void pickPDF() async {
  //   try {
  //     isPdfUploading.value = true;
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowedExtensions: ['pdf'],
  //     );
  //     if (result != null) {
  //       File file = File(result.files.first.path!);
  //       if (file.existsSync()) {
  //         Uint8List fileBytes = await file.readAsBytes();
  //         String fileName = result.files.first.name;
  //         print("File Bytes: $fileBytes");

  //         // final uploadService = Get.put(UploadService());
  //         //  final downloadURL = await uploadService.uploadPDF(fileBytes, fileName);
  //         //pdfUrl.value = downloadURL;
  //         // print(downloadURL);
  //       } else {
  //         print("File does not exist");
  //       }
  //     } else {
  //       print("No file selected");
  //     }
  //   } catch (e) {
  //     print("PDF upload error: $e");
  //   } finally {
  //     isPdfUploading.value = false;
  //   }
  // }
}
