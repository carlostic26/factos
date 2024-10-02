import 'package:factos/feature/launch/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_fifth_widget_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'welcome_barrel.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final currentPage = ref.watch(pageProvider);

    final listSelectedPreferences = ref.watch(listPreferencesProvider);
    final listSelectedCategories = ref.watch(listCategoryProvider);

    return Scaffold(
      backgroundColor: scaffoldBackgroundGlobalColor,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (int page) {
                ref.read(pageProvider.notifier).setPage(page);
              },
              children: const [
                WelcomeFirstPage(),
                WelcomeFactoCardSecondPage(),
                WelcomeStartThirdPage(),
                WelcomeCategoryFourthPage(),
                WelcomePreferencesFifthPage(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10),
              child: currentPage == 4
                  ? TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(buttonLigthColor),
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()));

                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        //Guardamos la lista blanca de preferencias
                        await prefs.setStringList('selectedPreferencesSaved',
                            listSelectedPreferences);

                        /*
                            
                    Future<List<String>> loadPreferences() async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      return prefs.getStringList('selectedPreferences') ?? []; // Devuelve una lista vacía si no hay preferencias guardadas
                    }

                            */

                        await prefs.setBool('firstWelcome', false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Preferencias guardadas'),
                          ),
                        );
                      },
                      child: const Text(
                        'Finalizar',
                        style: TextStyle(color: lightBackgroundTextColor),
                      ),
                    )
                  : IconButton(
                      iconSize: 30,
                      onPressed: () {
                        if (currentPage == 3 &&
                            listSelectedCategories.length + 1 < 3) {
                          Fluttertoast.showToast(
                            msg: "Selecciona al menos 3",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }

                        if (currentPage == 4 &&
                            listSelectedPreferences.length + 1 < 5) {
                          Fluttertoast.showToast(
                            msg: "Selecciona al menos 5",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }

                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SizedBox(height: 70, child: Placeholder()),
    );
  }
}
