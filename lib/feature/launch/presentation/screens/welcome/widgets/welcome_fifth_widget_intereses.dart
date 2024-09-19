import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_category_widget.dart';
import 'package:flutter/material.dart';

class WelcomeInteresesFifthPage extends StatelessWidget {
  const WelcomeInteresesFifthPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Lista de nombres de categorías
    final categories = [
      'Desarrollo Web',
      'Tips',
      'Tips',
      'Desarrollo Móvil',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Sugerencias',
      'Lenguajes',
      'Desarrollo de escritorio',
      'Motivacional',
      'Desarrollo de videojuegos',
      'Historia',
    ];

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
