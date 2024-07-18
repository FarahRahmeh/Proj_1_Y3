
import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/book.dart';
import '../../../utils/popups/loaders.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../add_book/cover_preview_page.dart';

class BookRequestController extends GetxController {
  // Variables book

  var isLoading = false.obs;
  var isNovel = false.obs;
  var isApproved;
  var isLocked = false.obs;
  var titleController = TextEditingController();
  var authorController = TextEditingController();
  var pubYearController = TextEditingController();
  var pointsController = TextEditingController();
  var pagesController = TextEditingController();
  var summaryController = TextEditingController();
  var localStorage = GetStorage();
  var _bookRepository = Get.put(BookRepository());
  var book = Book();
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
  var isImageUploading = false.obs;
  var imageUrl = Images.defaultBookCover.obs;

  //!File Varicables
  var pdfUrl = "".obs;
  var isPdfUploading = false.obs;

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
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
      print("PDF upload error: $e");
    } finally {
      isPdfUploading.value = false;
    }
  }

  // Future<void> removeBook(String id) async {
  //   try {
  //     final response = await _bookRepository.deleteBook(id);
  //     if (response.statusCode == 200) {
  //       // Handle success
  //       Loaders.successSnackBar(
  //           title: 'Success', message: 'Book deleted successfully!');
  //       final allBooksCtrl = Get.put(AllBooksController());
  //       allBooksCtrl.fetchAllBooks();
  //     } else {
  //       Loaders.errorSnackBAr(
  //           title: 'Error',
  //           message: 'Failed to delete book: ${response.statusCode}');
  //       print('Error delete book body ' + response.body);
  //     }
  //   } catch (error) {
  //     Loaders.errorSnackBAr(
  //         title: 'Error Catched on delete book',
  //         message: 'An error occurred: $error');
  //   }
  // }

  Future<void> saveBookRequest() async {
    if (!addBookFormKey.currentState!.validate()) {
      return;
    }
    try {
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
        Loaders.successSnackBar(
          title: 'Success',
          message: 'Book Request Sent successfully!',
        );
        final bookRequest = response.body;
        print(bookRequest);
        clearFields();
        final allBooksCtrl = Get.put(AllBooksController());
        allBooksCtrl.fetchAllBooks();
      } else {
        Loaders.errorSnackBar(
            title: 'Error',
            message: 'Failed to send book request: ${response.statusCode}');
        print('Error body ' + response.body);
      }
    } catch (error) {
      Loaders.errorSnackBar(
          title: 'Error Catched', message: 'An error occurred: $error');
    }
  }

  // void fetchBookRequest() async {
  //   try {
  //     isLoading.value = true;
  //     var bookRequest = BookRepository().getBookRequestData(
  //         title: titleController.text.trim(),
  //         author: authorController.text.trim(),
  //         publishedAt: pubYearController.text.trim(),
  //         points: pointsController.text.trim(),
  //         pagesNum: pagesController.text.trim(),
  //         language: selectedLanguage.value,
  //         summary: summaryController.text.trim(),
  //         genres: selecedGenres,
  //         isNovel: isNovel.value,
  //         isLocked: isLocked.value,
  //         cover: imageUrl.value,
  //         book: pdfUrl.value);
  //     if (bookRequest != "") {
  //       book = bookRequest ;
  //       populateBookData(book);
  //     }
  //   } catch (e) {
  //     print('Error in book request controller' + e.toString());
  //   }
  // }

  // void populateBookData(Book book) {
  //   titleController.text = book.name;
  //   authorController.text = book.writer;
  //   pubYearController.text = book.publicationYear;
  //   pointsController.text = book.points.toString();
  //   pagesController.text = book.pages.toString();
  //   summaryController.text = book.summary;
  //   selecedGenres.assignAll(book.genre as Iterable<String>);
  //   selectedLanguage.value = book.lang;
  //   imageUrl.value = book.cover ?? Images.defaultBookCover;
  // }
}
