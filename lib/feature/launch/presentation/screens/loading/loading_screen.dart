import 'package:factos/feature/home/presentation/screens/home_screen.dart';
import 'package:factos/feature/launch/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    final factosCountAsync = ref.watch(maxFactosState);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Creando  ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: subtitleTextColor,
                      fontSize: 12,
                      fontFamily: 'Inter_ExtraLight.ttf'),
                ),
                factosCountAsync.when(
                  data: (count) => CountingAnimation(endCount: count),
                  error: (error, stackTrace) => ErrorDisplay(
                      error: error,
                      onRetry: () {
                        ref.read(maxFactosState.notifier).updateFactosCount();
                      }),
                  loading: () => LoadingDisplay(),
                ),
                const Text(
                  " factos importantes",
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
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          bool firstWelcome =
                              prefs.getBool('firstWelcome') ?? true;

                          if (firstWelcome) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => (const WelcomeScreen())));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => (const HomeScreen())));
                          }
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

class ErrorDisplay extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const ErrorDisplay({Key? key, required this.error, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 60),
        const SizedBox(height: 16),
        Text(
          '...',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        Text(
          error.toString(),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('...'),
        ),
      ],
    );
  }
}

class LoadingDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(
          'Cargando conteo de factos...',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
