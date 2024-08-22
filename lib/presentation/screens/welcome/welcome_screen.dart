import 'package:factos/presentation/common/widgets/facto_widget.dart';
import 'package:factos/presentation/screens/welcome/widgets/welcome_first_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String variable = '';

    return const Scaffold(
      body: Center(child: FactoWidget()),
      bottomNavigationBar: SizedBox(height: 70, child: Placeholder()),
    );
  }
}
