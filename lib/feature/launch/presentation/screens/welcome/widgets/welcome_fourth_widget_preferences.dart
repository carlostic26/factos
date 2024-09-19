import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/presentation/provider/riverpod.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomePreferencesFourthPage extends ConsumerWidget {
  const WelcomePreferencesFourthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageProvider);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Rescatar la lista depreferencias de la bd
    final categories = [
      'Sugerencias',
      'Lenguajes',
      'Desarrollo de escritorio',
      'Motivacional',
      'Desarrollo de videojuegos',
      'Historia',
    ];

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
            Text('Elige almenos 3',
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
        Expanded(
          child: Center(
            child: Wrap(
              spacing: 3,
              runSpacing: 28,
              alignment: WrapAlignment.center,
              children: categories.map((category) {
                return FactosCategoryWidget(
                  categoryName: category,
                  widgetSelected: true,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
