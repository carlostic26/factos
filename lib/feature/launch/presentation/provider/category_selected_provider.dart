import 'package:riverpod/riverpod.dart';

// Provider que trae la lista de categorias de la base de datos
class CategoriesNotifier extends StateNotifier<List<bool>> {
  CategoriesNotifier() : super(List.generate(18, (index) => false));

  void toggleCategoryFromDb(int index) {
    state[index] = !state[index];
    state = List.from(state);
  }
}

final categoriesProviderDatabase =
    StateNotifierProvider<CategoriesNotifier, List<bool>>((ref) {
  return CategoriesNotifier();
});

//----------------------------------------------

// Provider de Categorias para shared preferences
class ListCategoriesProvider extends StateNotifier<List<String>> {
  ListCategoriesProvider() : super([]);

  // Método para agregar o eliminar categorias
  void toggleCategoryToSharedPreferences(String category) {
    if (state.contains(category)) {
      // Si ya existe, eliminarla
      state = state.where((p) => p != category).toList();
    } else {
      // Si no existe, agregarla
      state = [...state, category];
    }
  }
}

// Proveedor para las categorias para shared preferences
final listCategoryProviderToSharedPreferences =
    StateNotifierProvider<ListCategoriesProvider, List<String>>((ref) {
  return ListCategoriesProvider();
});
