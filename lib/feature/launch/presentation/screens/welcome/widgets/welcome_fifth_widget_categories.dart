import 'package:factos/feature/launch/presentation/provider/interests_user_provider.dart';
import 'package:factos/feature/launch/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_filter_widget.dart';

class WelcomeInteresesFifthPage extends ConsumerWidget {
  const WelcomeInteresesFifthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final selectedCategories = ref.watch(categoriesProvider);

    // ignore: unused_local_variable
    List<String> categoryList = [];

    final categoriesAsyncValue = ref.watch(categoriesFactoProvider);

    Future<void> loadCategories() async {
      final categoriesAsyncValue = ref.read(categoriesProvider.notifier);

      categoryList = categoriesAsyncValue as List<String>;
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
                  child: Text('2/2',
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

  Widget buildPreferencePage(
      List<String> categories, int pageIndex, double height, WidgetRef ref) {
    int start = pageIndex * 25;
    int end = (start + 25 < categories.length) ? start + 25 : categories.length;

    final listSelectedCategories = ref.watch(listCategoryProvider);

    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: categories.getRange(start, end).map((category) {
            int index = categories.indexOf(category);
            return GestureDetector(
              onTap: () {
                ref.read(categoriesProvider.notifier).togglePreference(index);

                print(
                    'NUMERO DE CATEGORIAS SELECCIONADAS: ${listSelectedCategories.length}');
              },
              child: SizedBox(
                height: height * 0.05,
                child: FactosFilterWidget(
                  categoryName: category,
                  widgetSelected: ref.watch(categoriesProvider)[index],
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
