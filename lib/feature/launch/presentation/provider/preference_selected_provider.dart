import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider que trae la lista de preferencias de la base de datos
class PreferencesNotifier extends StateNotifier<List<bool>> {
  PreferencesNotifier() : super(List.generate(18, (index) => false));

  void togglePreferenceFromDb(int index) {
    state[index] = !state[index];
    state = List.from(state);
  }

  // Método para cargar el estado desde SharedPreferences
  Future<void> loadPreferenceStateFromSharedPreferences(
      List<String> preferenceFromDb) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> preferenceFromShp =
        prefs.getStringList('selectedPreferencesSaved') ?? [];

    List<bool> newState =
        List.generate(preferenceFromDb.length, (index) => false);

    for (int i = 0; i < preferenceFromDb.length; i++) {
      if (preferenceFromShp.contains(preferenceFromDb[i])) {
        newState[i] = true;
      }
    }

    state = newState;
  }
}

final preferencesProviderDatabase =
    StateNotifierProvider<PreferencesNotifier, List<bool>>((ref) {
  return PreferencesNotifier();
});

//-------------------------------------------------
/* 
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
} */

final preferncesProviderDatabase =
    StateNotifierProvider<PreferencesNotifier, List<bool>>((ref) {
  return PreferencesNotifier();
});

class ListPreferencesProvider extends StateNotifier<List<String>> {
  ListPreferencesProvider() : super([]);

  // Método para agregar o eliminar categorias
  void addPreferenceToWhiteList(String category) {
    if (state.contains(category)) {
      // Si ya existe, eliminarla
      state = state.where((p) => p != category).toList();
    } else {
      // Si no existe, agregarla
      state = [...state, category];
    }
    _saveToSharedPreferences();
  }

  // Guardar la lista en SharedPreferences
  Future<void> _saveToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selectedPreferencesSaved', state);
  }

  // Cargar la lista desde SharedPreferences
  Future<void> loadPreferencesFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('selectedPreferencesSaved') ?? [];
  }
}

// Proveedor para las preferencias para shared preferences
final listPreferencesProviderToSharedPreferences =
    StateNotifierProvider<ListPreferencesProvider, List<String>>((ref) {
  return ListPreferencesProvider();
});
