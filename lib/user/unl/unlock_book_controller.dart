import 'package:booktaste/user/unl/unlock_book_model.dart';
import 'package:booktaste/user/unl/unlock_book_repository.dart';
import 'package:get/get.dart';

class UnlockBookController extends GetxController {
  var unlockBook = UnlockBook(
    id: 0,
    bookId: '',
    book: '',
    name: '',
    writer: '',
    cover: '',
    summary: '',
    lang: '',
    pagesNum: 0,
    genre: [],
    publishedAt: '',
    numOfReaders: 0,
    stars: 0,
    avgReadTime: null,
    numOfVoters: 0,
    isNovel: 0,
    isLocked: 0,
    points: null,
    createdAt: DateTime.now(),
  ).obs;

  var isLoading = false.obs;

  Future<void> fetchUnlockBook(String bookId) async {
    try {
      isLoading.value = true; 
      UnlockBook? result = await UnlockBookRepository.fechunlock(bookId);
      if (result != null) {
        unlockBook.value = result; 
      }
    } finally {
      isLoading.value = false; 
    }
  }
}
