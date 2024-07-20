import 'dart:convert';

import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/popups/loaders.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'cover_preview_page.dart';

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
  final _bookRepository = Get.put(BookRepository());

  GlobalKey<FormState> addBookFormKey = GlobalKey<FormState>();

  final borderColor = ValueNotifier<Color>(lightBrown.withOpacity(0.6));

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
// languages
  var selectedLanguage = 'Unknown'.obs;
  List<String> languages = [
    'Arabic',
    'English',
    'French',
    'German',
    'Chinese',
    'Japanese',
    'Korean',
  ];

  //!Image Variables
  final isImageUploading = false.obs;
  final imageUrl = Images.defaultBookCover.obs;

  //!File Varicables
  final pdfUrl = "".obs;
  final isPdfUploading = false.obs;
  //! Book request
  var bookRequests = <Map<String, dynamic>>[].obs;

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
    summaryController.clear();
    selecedGenres.clear();
    selectedLanguage.value = 'Unknown';
    selecedGenres.value = [];
    pdfUrl.value = "";
    isNovel.value = false;
    isLocked.value = false;
    imageUrl.value = Images.defaultBookCover;
  }

  //! Genres Handling
  void addGenre(String genre) {
    if (!selecedGenres.contains(genre)) {
      selecedGenres.add(genre);
      selecedGenres.refresh();
    }
  }

  void removeGenre(String genre) {
    if (selecedGenres.contains(genre)) {
      selecedGenres.remove(genre);
      selecedGenres.refresh();
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
      Loaders.errorSnackBar(title: 'error', message: e.toString());
      print("Image upload error: $e");
    } finally {
      isImageUploading.value = false;
    }
  }

  void previewImage() {
    if (imageUrl.value.isNotEmpty &&
        imageUrl.value != Images.defaultBookCover) {
      Get.to(() => CoverPreviewPage(imagePath: imageUrl.value));
    }
  }

  void pickPdf() async {
    isPdfUploading.value = true;
    try {
      // Use FilePicker to select a PDF file
      FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (pickedFile != null) {
        // Get the file path
        String filePath = pickedFile.files.single.path!;
        print('Selected PDF path: $filePath');
        pdfUrl.value = filePath;
        print(pdfUrl.value);
        // Create a File object
        // File pdfFile = File(filePath);
        // Call the upload method to http post
        // await uploadPdf(pdfFile);
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
      print("PDF upload error: $e");
    } finally {
      isPdfUploading.value = false;
    }
  }

  Future<void> removeBook(String id) async {
    try {
      final response = await _bookRepository.deleteBook(id);
      if (response.statusCode == 200) {
        // Handle success
        Loaders.successSnackBar(
            title: 'Success', message: 'Book deleted successfully!');

        //! these two lines are important to keep the app's books up to date ( immediately delete the selected book )
        final allBooksCtrl = Get.put(AllBooksController());
        allBooksCtrl.fetchAllBooks();
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to delete book: ${response.statusCode}');
        print('Error delete book body ' + response.body);
      }
    } catch (error) {
      Loaders.errorSnackBar(
          title: 'Error Catched on delete book',
          message: 'An error occurred: $error');
    }
  }

  Future<void> saveBook() async {
    if (!addBookFormKey.currentState!.validate()) {
      return;
    }
    try {
      final user = await isUser();
      print(user.toString() + 'in bookCtrl');

      final response = await _bookRepository.addBook(
          title: titleController.text.trim(),
          author: authorController.text.trim(),
          publishedAt: pubYearController.text.trim(),
          points: pointsController.text.trim(),
          pagesNum: pagesController.text.trim(),
          language: selectedLanguage.value,
          summary: summaryController.text.trim(),
          genres: selecedGenres,
          isNovel: isNovel.value,
          isLocked: isLocked.value,
          cover: imageUrl.value,
          book: pdfUrl.value);
      if (response.statusCode == 200) {
        if (user == true) {
          bookRequests.add(jsonDecode(response.body));
        }

        print(response.body);
        user == false
            ? Loaders.successSnackBar(
                title: 'Success',
                message: 'Book Added successfully! ✅',
                icon: Iconsax.emoji_normal_copy)
            : Loaders.successSnackBar(
                title: 'Success',
                message: 'Book Request sent for approval! ✅',
                icon: Iconsax.send_2_copy);

        // final bkReqCtrl = Get.put(BookRequestController());
        clearFields();
        // these two lines are important to keep the app's books up to date ( immediately show the new book )
        final allBooksCtrl = Get.put(AllBooksController());
        allBooksCtrl.fetchAllBooks();
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to add book: ${response.statusCode}');
        print('Error body ' + response.body);
      }
    } catch (error) {
      Loaders.errorSnackBar(
          title: 'Error Catched', message: 'An error occurred: $error');
    }
  }

  // void approveBookRequest(String id, String state) async {
  //   final requestIndex =
  //       bookRequests.indexWhere((book) => book['book_id'] == id);
  //   if (requestIndex != -1) {
  //     final response = await _bookRepository.changeBookRequestState(id, state);
  //     print(bookRequests.toString() + 'before');
  //     if (response.statusCode == 200) {
  //       bookRequests.removeAt(requestIndex);
  //       print(bookRequests);
  //     }
  //   }
  // }
}
