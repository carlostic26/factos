import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/provider/interests_user_provider.dart';
import 'package:factos/feature/launch/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePreferencesFourthPage extends ConsumerWidget {
  const WelcomePreferencesFourthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final selectedPreferences = ref.watch(preferencesProvider);

    // ignore: unused_local_variable
    List<String> preferenceList = [];

    final preferenceAsyncValue = ref.watch(preferenceFactoProvider);

    Future<void> loadCategories() async {
      final preferenceAsyncValue = ref.read(preferencesProvider.notifier);

      preferenceList = preferenceAsyncValue as List<String>;
    }

    loadCategories();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(35, 130, 8, 1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text('Selecciona tus preferencias',
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
            Text('Elige almenos 5',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Inter',
                )),
          ]),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        preferenceAsyncValue.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (preferenceList) {
              return Expanded(
                child: PageView.builder(
                  itemCount: (preferenceList.length / 25).ceil(),
                  itemBuilder: (context, index) {
                    return buildPreferencePage(
                        preferenceList, index, height, ref);
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
      List<String> preferences, int pageIndex, double height, WidgetRef ref) {
    int start = pageIndex * 25;
    int end =
        (start + 25 < preferences.length) ? start + 25 : preferences.length;

    final listSelectedPreferences = ref.watch(listPreferencesProvider);

    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: preferences.getRange(start, end).map((namePreference) {
            int index = preferences.indexOf(namePreference);
            return GestureDetector(
              onTap: () {
                ref.read(preferencesProvider.notifier).togglePreference(index);

                ref
                    .read(listPreferencesProvider.notifier)
                    .togglePreference(namePreference);

                print(
                    'Preferencias seleccionadas: ${listSelectedPreferences.join(', ')}');

                print(
                    'NUMERO DE PREFERENCIAS SELECCIONADAS: ${listSelectedPreferences.length + 1}');
              },
              child: SizedBox(
                height: height * 0.05,
                child: FactosFilterWidget(
                  categoryName: namePreference,
                  widgetSelected: ref.watch(preferencesProvider)[index],
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
