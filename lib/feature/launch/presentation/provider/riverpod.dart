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
