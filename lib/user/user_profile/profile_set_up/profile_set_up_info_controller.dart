import 'dart:convert';

import 'package:booktaste/admin/manage_books/add_book/cover_preview_page.dart';
import 'package:booktaste/user/navigation/user_navigation_menu.dart';
import 'package:booktaste/user/user_profile/user_profile_controller.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

class SetUpProfileController extends GetxController {
  // var profileUpdate = false.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController genresController = TextEditingController();
  //!Image Variables
  final isImageUploading = false.obs;
  final imageUrl = Images.user.obs;

  //! image handling
  void pickImage() async {
    isImageUploading.value = true;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        print(image.path);
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
    if (imageUrl.value.isNotEmpty && imageUrl.value != Images.user) {
      Get.to(() => CoverPreviewPage(imagePath: imageUrl.value));
    }
  }

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

  void toggleGenreSelection(String genre) {
    if (selecedGenres.contains(genre)) {
      removeGenre(genre);
    } else {
      addGenre(genre);
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading(true);
      var uri = Uri.parse('$baseUrl/updateProfile');
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll({
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        })
        ..fields['name'] = nameController.text.trim();

      for (int i = 0; i < selecedGenres.length; i++) {
        request.fields['genre[$i]'] = selecedGenres[i];
      }

      if (imageUrl.value != Images.user &&
          !imageUrl.value.toString().startsWith('/profiles')) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_photo',
          imageUrl.value,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        // var responseData = await http.Response.fromStream(response);
        Loaders.successSnackBar(
            title: 'Success', message: 'updated successfully');
        final ctrl = Get.put(ProfileController());
        ctrl.getProfileInfo();
        Get.off(() => UserNavigationMenu());
        // profile.value = profileFromJson(responseData.body);
      } else {
        // print(jsonEncode(response));
        errorMessage.value = 'Failed to update profile';
      }
    } catch (e) {
      print(selecedGenres);
      print(e.toString());
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
