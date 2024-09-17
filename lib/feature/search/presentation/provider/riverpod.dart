import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/welcome_barrel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';

// Estado para la búsqueda
class SearchState {
  final List<FactoModel> searchResults;
  final bool isLoading;
  final String? error;

  SearchState({
    required this.searchResults,
    this.isLoading = false,
    this.error,
  });

  SearchState copyWith({
    List<FactoModel>? searchResults,
    bool? isLoading,
    String? error,
  }) {
    return SearchState(
      searchResults: searchResults ?? this.searchResults,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Notifier para manejar la lógica de búsqueda
class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(SearchState(searchResults: []));

  Future<void> searchFactos(String word) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final databaseHelper = SQLiteFactoLocalDatasourceImpl();
      final results = await databaseHelper.getFactosListByWord(word);
      state = state.copyWith(searchResults: results, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final isSearchBarBoolean = StateProvider((ref) => false);

final isClosedSearchBarScreen = StateProvider((ref) => false);

// Provider para el estado de búsqueda
final searchProvider =
    StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier();
});

// Provider para exponer la función de búsqueda
final searchFactosProvider = Provider<Future<void> Function(String)>((ref) {
  return (String word) => ref.read(searchProvider.notifier).searchFactos(word);
});

final textEditingControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  // Limpiar el controlador al eliminar el Provider
  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});
