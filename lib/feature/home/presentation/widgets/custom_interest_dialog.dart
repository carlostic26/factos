import 'package:factos/feature/launch/presentation/provider/category_selected_provider.dart';
import 'package:factos/feature/launch/presentation/provider/preference_selected_provider.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_fifth_widget_preferences.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_fourth_widget_categories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomInterestDialog extends ConsumerWidget {
  const CustomInterestDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPreferenceDialogContent(ref: ref);
  }

  void show(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      barrierColor: const Color.fromARGB(255, 13, 12, 12).withOpacity(0.7),
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }
}

class CustomPreferenceDialogContent extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const CustomPreferenceDialogContent({super.key, required this.ref});

  @override
  _CustomPreferenceDialogContentState createState() =>
      _CustomPreferenceDialogContentState();
}

class _CustomPreferenceDialogContentState
    extends ConsumerState<CustomPreferenceDialogContent> {
  List<String> categoryListFromDatabase = [];
  int currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadCategories() async {
    final categoriesAsyncValue = ref.read(categoriesProviderDatabase.notifier);
    setState(() {
      categoryListFromDatabase = categoriesAsyncValue as List<String>;
    });
  }

  Widget buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 2; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == currentPage ? Colors.white : Colors.grey,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final listSelectedCategoriesToSharedPreferences =
        ref.watch(listCategoryProviderToSharedPreferences);
    final listSelectedPreferencesToSharedPreferences =
        ref.watch(listPreferencesProviderToSharedPreferences);

    // Actualizar el estado basado en las categorías guardadas en SharedPreferences
    //ref.read(categoriesProviderDatabaseShp.notifier).updateStateFromShp(categoriesProviderDatabaseShp);

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    return Stack(
      children: [
        AlertDialog(
          backgroundColor: backgroundFilterDialog,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: width * 0.89,
            height: height * 0.50,
            decoration: BoxDecoration(
              color: backgroundFilterDialog,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    children: const [
                      WelcomeCategoryFourthPage(),
                      WelcomePreferencesFifthPage(),
                    ],
                  ),
                ),
                buildProgressIndicator(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Positioned(
          top: height * 0.715,
          left: width * 0.4,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              if (currentPage == 0) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                //Guardamos la lista blanca de preferencias
                await prefs.setStringList('selectedPreferencesSaved',
                    listSelectedPreferencesToSharedPreferences);

                await prefs.setStringList('selectedCategoriesSaved',
                    listSelectedCategoriesToSharedPreferences);

                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('Intereses guardados'),
                  ),
                );

                Navigator.pop(context);
              }
            },
            child: Text(
              currentPage < 1 ? 'Siguiente' : 'Guardar',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
