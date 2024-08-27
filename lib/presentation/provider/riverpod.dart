import 'package:riverpod/riverpod.dart';

final maxFactosState = StateProvider((ref) => 121325);

//final buttonState = StateProvider((ref) => false);

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
