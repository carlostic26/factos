import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/presentation/common/widgets/facto_widget.dart';
import 'package:flutter/material.dart';

class WelcomeFactoCardSecondPage extends StatelessWidget {
  const WelcomeFactoCardSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
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
              SizedBox(height: height * 0.03),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ExampleFactoWidget(
                    title: 'El lenguaje que cambió el juego',
                    subtitle:
                        'Fortran es el papá. Asi de simple. En 1957 los genios de IBM crearon Fortran, el primer lenguaje de programación de alto nivel. Antes de esto, programar era como hablar con la máquina en su...',
                    font: 'Fortran',
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: ExampleFactoWidget(
                    title: 'La reina de los compiladores',
                    subtitle:
                        'Esta mujer es la reina de los compiladores. No hay otra forma de describirla. Grace Hopper, siendo naval, creó el primer compilador en 1952, sentando las bases de los lenguajes de programación modernos. Además, popularizó el término bug en...',
                    font: 'CIS',
                  )),
              Align(
                  alignment: Alignment.centerLeft,
                  child: ExampleFactoWidget(
                    title: 'Cambió el juego...',
                    subtitle:
                        'Linus Torvalds creó Linux en su habitación a los 21 años. Hoy, su sistema operativo domina servidores y supercomputadoras. ¡Poder al open source! Este finlandés demostró que la colaboración global puede crear maravillas tecnológicas.',
                    font: 'LinuxFoundation',
                  )),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
