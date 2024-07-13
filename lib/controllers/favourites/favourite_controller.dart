import 'package:booktaste/models/book_model.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class FavController extends GetxController {
  static FavController get instance => Get.find();
  //Varibales
  // final favourites = <String, bool>{}.obs;

  var numOfItems = 0.obs;
  var favList = <BookModel>[].obs;

  void addFavToList(BookModel book) {
    if (!favList.contains(book)) {
      favList.add(book);
      numOfItems++;

      //   //favList.refresh();
      // } else {
      //   favList.remove(book);
      //   numOfItems--;

      //   // favList.refresh();
      //   // Loaders.warningSnackBar(title: 'You Already Added this to Favourites');
    }
  }

  void removeFavFromList(BookModel book) {
    if (favList.contains(book)) {
      favList.remove(book);
      numOfItems--;
    }
  }

  bool isFav(BookModel book) {
    return favList.contains(book);
  }

//   @override
//   void onInit() {
//     super.onInit();
//     initFavs();
//   }

//   Future<void> initFavs() async {}
}
