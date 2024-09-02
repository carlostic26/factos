import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/presentation/provider/riverpod.dart';
import 'package:factos/feature/home/presentation/screens/home/home_screen.dart';
import 'package:factos/feature/launch/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/screens/loading/widgets/counting_animation.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/welcome_screen.dart';
import 'package:factos/feature/webview/presentation/screens/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonContinue = ref.watch(buttonState);
    bool isLoaded = false;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Future.delayed(const Duration(seconds: 1), () {
      ref.read(buttonState.notifier).enableButton();
      isLoaded = true;
    });

    return Scaffold(
      body: Container(
        color: scaffoldBackgroundGlobalColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: height * 0.22,
                width: width * 0.65,
                child: Image.asset('assets/images/logo.png')),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: LinearPercentIndicator(
                  alignment: MainAxisAlignment.center,
                  width: width * 0.65,
                  lineHeight: 7,
                  percent: 100 / 100,
                  animation: true,
                  animationDuration: 10000,
                  progressColor: Colors.blueGrey),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Recopilando  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: subtitleTextColor,
                      fontSize: 12,
                      fontFamily: 'Inter_ExtraLight.ttf'),
                ),
                CountingAnimation(endCount: 1225),
                Text(
                  " factos...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: subtitleTextColor,
                      fontSize: 12,
                      fontFamily: 'Inter_ExtraLight.ttf'),
                ),
              ],
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const WebviewScreen()));
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
      ),
    );
  }
}
