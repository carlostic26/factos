import 'package:factos/core/common/provider/ads_providers.dart';
import 'package:factos/feature/launch/presentation/provider/category_selected_provider.dart';
import 'package:factos/feature/launch/presentation/provider/preference_selected_provider.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_fifth_widget_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_barrel.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = PageController();
    final currentPage = ref.watch(pageProvider);

    final listSelectedCategoriesToSharedPreferences =
        ref.watch(listCategoryProviderToSharedPreferences);
    final listSelectedPreferencesToSharedPreferences =
        ref.watch(listPreferencesProviderToSharedPreferences);

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final adsState = ref.watch(adsProvider);

    // Cargar el anuncio cuando se construye el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(adsProvider.notifier).loadAdaptiveAd(context);
    });

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
                        if (currentPage == 4 &&
                            listSelectedPreferencesToSharedPreferences.length +
                                    1 >
                                5) {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          //Guardamos la lista blanca de preferencias
                          await prefs.setStringList('selectedPreferencesSaved',
                              listSelectedPreferencesToSharedPreferences);

                          await prefs.setStringList('selectedCategoriesSaved',
                              listSelectedCategoriesToSharedPreferences);

                          await prefs.setBool('firstWelcome', false);

                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text('Intereses guardados'),
                            ),
                          );

                          navigator.push(MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                        } else if (currentPage == 4) {
                          Fluttertoast.showToast(
                            msg: "Selecciona al menos 5",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );
                        }
                      },
                      child: const Text(
                        'Finalizar',
                        style: TextStyle(color: lightBackgroundTextColor),
                      ),
                    )
                  : IconButton(
                      iconSize: 30,
                      onPressed: () async {
                        if (currentPage < 3) {
                          nextPage(pageController);
                        }

                        if (currentPage == 3 &&
                            listSelectedCategoriesToSharedPreferences.length +
                                    1 >
                                3) {
                          nextPage(pageController);
                        } else if (currentPage == 3) {
                          Fluttertoast.showToast(
                            msg: "Selecciona al menos 3",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );
                        }
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
      bottomNavigationBar: adsState.anchoredAdaptiveAd != null
          ? Container(
              color: Colors.transparent,
              width: adsState.anchoredAdaptiveAd!.size.width.toDouble(),
              height: adsState.anchoredAdaptiveAd!.size.height.toDouble(),
              child: AdWidget(ad: adsState.anchoredAdaptiveAd!),
            )
          : const SizedBox(),
    );
  }

  PageController nextPage(pageController) {
    return pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
