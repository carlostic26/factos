import 'package:factos/feature/launch/presentation/provider/category_selected_provider.dart';
import 'package:factos/feature/launch/presentation/provider/interests_user_provider.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_filter_widget.dart';

class WelcomeCategoryFourthPage extends ConsumerWidget {
  const WelcomeCategoryFourthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(35, 130, 8, 1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    return buildPreferencePage(
                        categoryList, index, height, ref);
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

  Widget buildPreferencePage(List<String> categoryListDatabase, int pageIndex,
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
                    .toggleCategoryToSharedPreferences(nameCategory);

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

  Widget buildCategoriaPage(List<String> categorias, int pageIndex,
      double height, StateSetter setState, List<bool> selectedCategorias) {
    int start = pageIndex * 7;
    int end = (start + 7 < categorias.length) ? start + 7 : categorias.length;

    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: categorias.getRange(start, end).map((category) {
            int index = categorias.indexOf(category);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategorias[index] = !selectedCategorias[index];
                });
              },
              child: SizedBox(
                height: height * 0.04,
                child: FactosFilterWidget(
                  categoryName: category,
                  widgetSelected: selectedCategorias[index],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
