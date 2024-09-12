import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonStateNotifier extends StateNotifier<bool> {
  ButtonStateNotifier() : super(false);

  void enableButton() {
    state = true;
  }
}

final buttonState = StateNotifierProvider<ButtonStateNotifier, bool>((ref) {
  return ButtonStateNotifier();
});

class PageNotifier extends StateNotifier<int> {
  PageNotifier() : super(0);

  void setPage(int page) {
    state = page;
  }
}

final pageProvider = StateNotifierProvider<PageNotifier, int>((ref) {
  return PageNotifier();
});

//final buttonSavedFactoState = StateProvider((ref) => false);

final bookmarkedTitlesProvider =
    StateNotifierProvider<BookmarkedTitlesNotifier, List<String>>((ref) {
  return BookmarkedTitlesNotifier();
});

class BookmarkedTitlesNotifier extends StateNotifier<List<String>> {
  BookmarkedTitlesNotifier() : super([]) {
    _loadBookmarkedTitles();
  }

  Future<void> _loadBookmarkedTitles() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('titles') ?? [];
  }

  Future<void> toggleBookmark(String title) async {
    final prefs = await SharedPreferences.getInstance();
    if (state.contains(title)) {
      state = state.where((t) => t != title).toList();
    } else {
      state = [...state, title];
    }
    await prefs.setStringList('titles', state);
  }
}
