import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider que trae la lista de categorias de la base de datos
class CategoriesNotifier extends StateNotifier<List<bool>> {
  CategoriesNotifier() : super(List.generate(18, (index) => false));

  void toggleCategoryFromDb(int index) {
    state[index] = !state[index];
    state = List.from(state);
  }

  // Método para cargar el estado desde SharedPreferences
  Future<void> loadCategoryStateFromSharedPreferences(
      List<String> categoriesFromDb) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> categoriesFromShp =
        prefs.getStringList('selectedCategoriesSaved') ?? [];

    List<bool> newState =
        List.generate(categoriesFromDb.length, (index) => false);

    for (int i = 0; i < categoriesFromDb.length; i++) {
      if (categoriesFromShp.contains(categoriesFromDb[i])) {
        newState[i] = true;
      }
    }

    state = newState;
  }
}

final categoriesProviderDatabase =
    StateNotifierProvider<CategoriesNotifier, List<bool>>((ref) {
  return CategoriesNotifier();
});

class ListCategoriesProvider extends StateNotifier<List<String>> {
  ListCategoriesProvider() : super([]);

  // Método para agregar o eliminar categorias
  void addCategoryToWhiteList(String category) {
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
    prefs.setStringList('selectedCategoriesSaved', state);
  }

  // Cargar la lista desde SharedPreferences
  Future<void> loadCategoriesFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('selectedCategoriesSaved') ?? [];
  }
}

final listCategoryProviderToSharedPreferences =
    StateNotifierProvider<ListCategoriesProvider, List<String>>((ref) {
  return ListCategoriesProvider();
});
