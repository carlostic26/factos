import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/presentation/common/widgets/facto_widget.dart';
import 'package:flutter/material.dart';

class WelcomeSecondPage extends StatelessWidget {
  const WelcomeSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.15),
              child: const Text(
                textAlign: TextAlign.center,
                'Un “Facto” es un dato contundente que todos los devs deberían conocer...',
                style: TextStyle(
                  height: 1.2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: darkBackgroundTextColor,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
            const Align(alignment: Alignment.centerLeft, child: FactoWidget()),
            const Align(alignment: Alignment.centerRight, child: FactoWidget()),
            const Align(alignment: Alignment.centerLeft, child: FactoWidget()),
            SizedBox(height: height * 0.1),
          ],
        ),
      ),
    );
  }
}
