import 'package:factos/feature/launch/presentation/provider/category_selected_provider.dart';
import 'package:factos/feature/launch/presentation/provider/interests_user_provider.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_filter_widget.dart';

class WelcomeCategoryFourthPage extends ConsumerStatefulWidget {
  const WelcomeCategoryFourthPage({super.key});

  @override
  _WelcomeCategoryFourthPageState createState() =>
      _WelcomeCategoryFourthPageState();
}

class _WelcomeCategoryFourthPageState
    extends ConsumerState<WelcomeCategoryFourthPage> {
  List<String> categoryListFromDatabase = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    // Cargar las categorías desde la base de datos
    final categories = await ref.read(categoriesFactoProvider.future);
    categoryListFromDatabase = categories;

    // Cargar la lista blanca desde SharedPreferences
    await ref
        .read(listCategoryProviderToSharedPreferences.notifier)
        .loadFromSharedPreferences();

    // Actualizar el estado basado en las categorías guardadas en SharedPreferences
    await ref
        .read(categoriesProviderDatabase.notifier)
        .loadStateFromSharedPreferences(categoryListFromDatabase);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    // ignore: unused_local_variable
    List<String> categoryListFromDatabase = [];

    final categoriesAsyncValue = ref.watch(categoriesFactoProvider);

    Future<void> loadCategories() async {
      final categoriesAsyncValue =
          ref.read(categoriesProviderDatabase.notifier);

      categoryListFromDatabase = categoriesAsyncValue as List<String>;
    }

    loadCategories();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(35, 130, 8, 1),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Selecciona tus categorías',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: titleTextColor,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold)),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 35),
                      child: Text('1/2',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: titleTextColor,
                            fontSize: 16,
                            fontFamily: 'Inter',
                          )),
                    ),
                  ],
                ),
                Text('Elige almenos 3',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                    )),
              ]),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        categoriesAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (categoryList) {
              return Expanded(
                child: PageView.builder(
                  itemCount: (categoryList.length / 25).ceil(),
                  itemBuilder: (context, index) {
                    return buildCategoryPage(categoryList, index, height, ref);
                  },
                ),
              );
            }),
      ],
    );
  }

  Widget buildProgressIndicator(int totalItems, int currentPage) {
    int totalPages = (totalItems / 7).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: index == currentPage ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  Widget buildCategoryPage(List<String> categoryListDatabase, int pageIndex,
      double height, WidgetRef ref) {
    int start = pageIndex * 25;
    int end = (start + 25 < categoryListDatabase.length)
        ? start + 25
        : categoryListDatabase.length;

    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children:
              categoryListDatabase.getRange(start, end).map((nameCategory) {
            int index = categoryListDatabase.indexOf(nameCategory);
            return GestureDetector(
              onTap: () {
                ref
                    .read(categoriesProviderDatabase.notifier)
                    .toggleCategoryFromDb(index);

                //este ref envia las categorias que el usuario vaya eligiendo a la lista blanca
                ref
                    .read(listCategoryProviderToSharedPreferences.notifier)
                    .addCategoryToWhiteList(nameCategory);

                final countListCategories =
                    ref.watch(listCategoryProviderToSharedPreferences);

                print(
                    'CONTADOR DE CATEGORIAS SELECCIONADAS: $countListCategories');
              },
              child: SizedBox(
                height: height * 0.05,
                child: FactosFilterWidget(
                  categoryName: nameCategory,
                  widgetSelected: ref.watch(categoriesProviderDatabase)[index],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
