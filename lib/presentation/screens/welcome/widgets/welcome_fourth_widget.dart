import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/presentation/screens/welcome/widgets/factos_category_widget.dart';
import 'package:flutter/material.dart';

class WelcomeFourthWidget extends StatelessWidget {
  const WelcomeFourthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(8, 50, 8, 1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Selecciona tus intereses',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold)),
            Text('Elige almenos 3',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Inter',
                )),
          ]),
        ),
        const Expanded(
          child: SizedBox(),
        ),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const FactosCategoryWidget(),
        const Expanded(
          child: SizedBox(),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(buttonLigthColor)),
                onPressed: () {},
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: lightBackgroundTextColor),
                ),
              ),
            )),
      ],
    );
  }
}
