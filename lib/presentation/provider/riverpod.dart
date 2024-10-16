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
