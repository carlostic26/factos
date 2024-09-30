import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod/riverpod.dart';

// Provider para SQLiteFactoLocalDatasourceImpl
final factoLocalDatasourceProvider = Provider<FactoLocalDatasource>((ref) {
  return SQLiteFactoLocalDatasourceImpl();
});

final maxFactosState = AsyncNotifierProvider<MaxFactosNotifier, int>(() {
  return MaxFactosNotifier();
});

class MaxFactosNotifier extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    final datasource = ref.watch(factoLocalDatasourceProvider);
    return _getCount(datasource);
  }

  Future<int> _getCount(FactoLocalDatasource datasource) async {
    final count = await datasource.countFactos();
    print('COUNT VALE: $count');
    return count;
  }

  Future<void> updateFactosCount() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final datasource = ref.read(factoLocalDatasourceProvider);
      return _getCount(datasource);
    });
  }
}

// Proveedor para las preferencias
class listPreferencesNotifier extends StateNotifier<List<String>> {
  listPreferencesNotifier() : super([]);

  // Método para agregar o eliminar preferencias
  void togglePreference(String preference) {
    if (state.contains(preference)) {
      // Si ya existe, eliminarla
      state = state.where((p) => p != preference).toList();
    } else {
      // Si no existe, agregarla
      state = [...state, preference];
    }
  }
}

// Proveedor para las preferencias
final listPreferencesProvider =
    StateNotifierProvider<listPreferencesNotifier, List<String>>((ref) {
  return listPreferencesNotifier();
});

// Proveedor para las categorias
class listCategoryNotifier extends StateNotifier<List<String>> {
  listCategoryNotifier() : super([]);

  // Método para agregar o eliminar preferencias
  void toggleCategory(String category) {
    if (state.contains(category)) {
      // Si ya existe, eliminarla
      state = state.where((p) => p != category).toList();
    } else {
      // Si no existe, agregarla
      state = [...state, category];
    }
  }
}

// Proveedor para las preferencias
final listCategoryProvider =
    StateNotifierProvider<listCategoryNotifier, List<String>>((ref) {
  return listCategoryNotifier();
});

//-------

final animationControllerProvider = Provider.autoDispose((ref) {
  final controller = AnimationController(
    duration: const Duration(seconds: 9),
    vsync: ref.watch(vsyncProvider),
  );
  ref.onDispose(() => controller.dispose());
  controller.forward();
  return controller;
});

final vsyncProvider = Provider.autoDispose((ref) => VSyncProviderImpl());

class VSyncProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

final animationValueProvider = Provider.family.autoDispose((ref, int endCount) {
  final controller = ref.watch(animationControllerProvider);
  return Tween<double>(begin: 0, end: endCount.toDouble()).animate(controller);
});

final textColorProvider = Provider((ref) => Colors.white);

class PreferencesNotifier extends StateNotifier<List<bool>> {
  PreferencesNotifier() : super(List.generate(18, (index) => false));

  void togglePreference(int index) {
    state[index] = !state[index];
    state = List.from(state);
  }
}

final preferencesProvider =
    StateNotifierProvider<PreferencesNotifier, List<bool>>((ref) {
  return PreferencesNotifier();
});

class CategoriesNotifier extends StateNotifier<List<bool>> {
  CategoriesNotifier() : super(List.generate(18, (index) => false));

  void togglePreference(int index) {
    state[index] = !state[index];
    state = List.from(state);
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<bool>>((ref) {
  return CategoriesNotifier();
});
