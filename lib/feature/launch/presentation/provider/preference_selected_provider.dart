import 'package:riverpod/riverpod.dart';

// Provider que trae la lista de preferencias de la base de datos
class PreferencesNotifier extends StateNotifier<List<bool>> {
  PreferencesNotifier() : super(List.generate(18, (index) => false));

  void togglePreferenceFromDb(int index) {
    state[index] = !state[index];
    state = List.from(state);
  }
}

final preferencesProviderDatabase =
    StateNotifierProvider<PreferencesNotifier, List<bool>>((ref) {
  return PreferencesNotifier();
});

//-------------------------------------------------

// Proveedor para las preferencias para shared preferences
class ListPreferencesNotifier extends StateNotifier<List<String>> {
  ListPreferencesNotifier() : super([]);

  // Método para agregar o eliminar preferencias
  void togglePreferenceToSharedPreferences(String preference) {
    if (state.contains(preference)) {
      // Si ya existe, eliminarla
      state = state.where((p) => p != preference).toList();
    } else {
      // Si no existe, agregarla
      state = [...state, preference];
    }
  }
}

// Proveedor para las preferencias para shared preferences
final listPreferencesProviderToSharedPreferences =
    StateNotifierProvider<ListPreferencesNotifier, List<String>>((ref) {
  return ListPreferencesNotifier();
});
