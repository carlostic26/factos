import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod/riverpod.dart';

//final maxFactosState = StateProvider((ref) => 1200);

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
