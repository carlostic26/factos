import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/presentation/provider/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numFactos = ref.watch(maxFactosState);
    final buttonContinue = ref.watch(buttonState);
    bool isLoaded = false;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future.delayed(const Duration(seconds: 10), () {
      ref.read(buttonState.notifier).enableButton();
      isLoaded = true;
    });

    return Container(
      color: scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 200, width: 200, child: Placeholder()),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                width: width * 0.8,
                lineHeight: 10,
                percent: 100 / 100,
                animation: true,
                animationDuration: 10000,
                progressColor: Colors.blueGrey),
          ),
          Text(
            textAlign: TextAlign.center,
            "Recopilando $numFactos factos...",
            style: const TextStyle(color: subtitleTextColor, fontSize: 12),
          ),
          const SizedBox(
            height: 80,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: TextButton(
                onPressed: buttonContinue
                    ? () async {
                        //go to welcomscreen || go to homeScreen
                      }
                    : null,
                style: ButtonStyle(
                  backgroundColor: buttonContinue
                      ? WidgetStateProperty.all<Color>(buttonLigthColor)
                      : WidgetStateProperty.all<Color>(Colors.white),
                ),
                child: Text(
                  'Continuar',
                  style: TextStyle(
                      fontSize: 10,
                      color: buttonContinue ? Colors.black : Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
