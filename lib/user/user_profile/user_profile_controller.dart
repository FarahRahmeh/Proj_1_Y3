import 'package:booktaste/admin/manage_books/add_book/cover_preview_page.dart';
import 'package:booktaste/user/user_profile/profile_model.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';

// class ProfileController extends GetxController {
//   var profile = Profile().obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     getProfileInfo();
//     super.onInit();
//   }

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController imageController = TextEditingController();
//   final TextEditingController genresController = TextEditingController();
//   //!Image Variables
//   final isImageUploading = false.obs;
//   final imageUrl = Images.user.obs;

//   //! image handling
//   void pickImage() async {
//     isImageUploading.value = true;
//     try {
//       final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         print(image.path);
//         imageUrl.value = image.path;
//       }
//     } catch (e) {
//       Loaders.errorSnackBar(title: 'error', message: e.toString());
//       print("Image upload error: $e");
//     } finally {
//       isImageUploading.value = false;
//     }
//   }

//   void previewImage() {
//     if (imageUrl.value.isNotEmpty && imageUrl.value != Images.user) {
//       Get.to(() => CoverPreviewPage(imagePath: imageUrl.value));
//     }
//   }

//   var selecedGenres = <String>[].obs;
//   List<String> genres = [
//     'Fantasy',
//     'Romance',
//     'Poetry',
//     'Drama',
//     'Literature',
//     'Fairy Tales & Folklore',
//     'Mystery',
//     'Thriller',
//     'Horror',
//     'Adventure',
//     'Crime',
//     'Comics',
//     'Manga',
//     'Humor',
//     'Science Fiction',
//     'Science',
//     'Technology',
//     'Travel',
//     'Religion',
//     'History',
//     'Philosophy',
//     'Psychology',
//     'Life Stories',
//     'Health',
//     'Business',
//     'Self-Help',
//     'Education',
//     'Children’s Literature',
//     'Picture Book',
//     'Young Adult',
//   ];
//   void addGenre(String genre) {
//     if (!selecedGenres.contains(genre)) {
//       selecedGenres.add(genre);
//       selecedGenres.refresh();
//     }
//   }

//   void removeGenre(String genre) {
//     if (selecedGenres.contains(genre)) {
//       selecedGenres.remove(genre);
//       selecedGenres.refresh();
//     }
//   }

//   void toggleGenreSelection(String genre) {
//     if (selecedGenres.contains(genre)) {
//       removeGenre(genre);
//     } else {
//       addGenre(genre);
//     }
//   }

//   Future<void> getProfileInfo() async {
//     try {
//       isLoading(true);

//       var response = await http.get(
//         Uri.parse('$baseUrl/profile'),
//         headers: {
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
//           'Connection': 'keep-alive',
//           'Accept-Encoding': 'gzip, deflate, br',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//       );

//       if (response.statusCode == 200) {
//         profile.value = profileFromJson(response.body);
//       } else {
//         errorMessage.value = 'Failed to fetch profile';
//       }
//     } catch (e) {
//       print(selecedGenres);
//       print(e.toString());
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading(false);
//     }
//   }
// }
// class ProfileController extends GetxController {
//   var profile = Profile().obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     getProfileInfo();
//     if (GetStorage().read('LEVEL') == null) {
//       getProfileInfo();
//     }
//     super.onInit();
//   }

//   // Fetch profile information and check for level-up
//   // Future<void> getProfileInfo() async {
//   //   try {
//   //     isLoading(true);

//   //     var response = await http.get(
//   //       Uri.parse('$baseUrl/profile'),
//   //       headers: {
//   //         'Accept': 'application/json',
//   //         'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
//   //         'Connection': 'keep-alive',
//   //         'Accept-Encoding': 'gzip, deflate, br',
//   //         'Content-Type': 'application/x-www-form-urlencoded',
//   //       },
//   //     );

//   //     if (response.statusCode == 200) {
//   //       profile.value = profileFromJson(response.body);

//   //       int currentAchievementId = profile.value.achievementId ?? 0;
//   //       int? previousAchievementId = GetStorage().read('ACHIEVEMENT_ID');

//   //       if (previousAchievementId == null) {
//   //         // If this is the first time, store the current achievement ID
//   //         GetStorage().write('ACHIEVEMENT_ID', currentAchievementId);
//   //       } else if (currentAchievementId > previousAchievementId) {
//   //         // User leveled up, show the popup
//   //         showLevelUpDialog(currentAchievementId);
//   //         // Update the stored achievement ID
//   //         GetStorage().write('ACHIEVEMENT_ID', currentAchievementId);
//   //       }
//   //     } else {
//   //       errorMessage.value = 'Failed to fetch profile';
//   //     }
//   //   } catch (e) {
//   //     print(e.toString());
//   //     errorMessage.value = 'Error: $e';
//   //   } finally {
//   //     isLoading(false);
//   //   }
//   // }
//   Future<void> getProfileInfo() async {
//     try {
//       isLoading(true);

//       var response = await http.get(
//         Uri.parse('$baseUrl/profile'),
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
//           'Connection': 'keep-alive',
//           'Accept-Encoding': 'gzip, deflate, br',
//         },
//       );

//       if (response.statusCode == 200) {
//         profile.value = profileFromJson(response.body);

//         // Check for null favGenres and initialize if needed
//         if (profile.value.favGenres == null ||
//             profile.value.favGenres!.isEmpty) {
//           profile.value.favGenres = [];
//         }

//         int currentAchievementId = profile.value.achievementId ?? 0;
//         int? previousAchievementId = GetStorage().read('LEVEL');
//         print('user Level' + GetStorage().read('LEVEL'));

//         if (previousAchievementId == null) {
//           // Store the current achievement ID
//           GetStorage().write('LEVEL', currentAchievementId);
//         } else if (currentAchievementId > previousAchievementId) {
//           // User leveled up, show the popup
//           showLevelUpDialog(currentAchievementId);
//           // Update the stored achievement ID
//           GetStorage().write('LEVEL', currentAchievementId);
//         }
//       } else {
//         errorMessage.value = 'Failed to fetch profile';
//       }
//     } catch (e) {
//       print(e.toString());
//       errorMessage.value = 'Error: $e';
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Method to show the level-up dialog
//   void showLevelUpDialog(int newLevel) {
//     Get.dialog(
//       AlertDialog(
//         title: Text('Congratulations!'),
//         content: Text('You have reached Level $newLevel!'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Get.back(); // Close the dialog
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//       barrierDismissible:
//           false, // Prevent the dialog from being dismissed by tapping outside
//     );
//   }
// }

class ProfileController extends GetxController {
  var profile = Profile().obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var currentLevel = 0.obs; // Observable variable for current level

  @override
  void onInit() {
    super.onInit();
    getProfileInfo();
    if (GetStorage().read('LEVEL') == null) {
      getProfileInfo();
    }
  }

  Future<void> getProfileInfo() async {
    try {
      isLoading(true);

      var response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      if (response.statusCode == 200) {
        profile.value = profileFromJson(response.body);

        // Check for null favGenres and initialize if needed
        if (profile.value.favGenres == null ||
            profile.value.favGenres!.isEmpty) {
          profile.value.favGenres = [];
        }

        int newLevel = profile.value.achievementId ?? 0;
        int? previousLevel = GetStorage().read('LEVEL');

        if (previousLevel == null) {
          // Store the current level
          GetStorage().write('LEVEL', newLevel);
          currentLevel.value = newLevel; // Update the observable variable
        } else if (newLevel > previousLevel) {
          Loaders.successSnackBar(
              title: 'Congratulations!',
              message: 'You have reached Level $newLevel!');
          // User leveled up, show the popup
          // showLevelUpDialog(newLevel);
          // Update the stored level
          GetStorage().write('LEVEL', newLevel);
          currentLevel.value = newLevel; // Update the observable variable
        }
      } else {
        errorMessage.value = 'Failed to fetch profile';
      }
    } catch (e) {
      print(e.toString());
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  void showLevelUpDialog(int newLevel) {
    Get.dialog(
      AlertDialog(
        title: Text('Congratulations!'),
        content: Text('You have reached Level $newLevel!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
      barrierDismissible:
          false, // Prevent the dialog from being dismissed by tapping outside
    );
  }
}
