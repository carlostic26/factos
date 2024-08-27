import 'package:flutter/material.dart';

class WelcomeFirstPage extends StatelessWidget {
  const WelcomeFirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          const Text(
            textAlign: TextAlign.center,
            'Bienvenido a \nFactos de Programación',
            style: TextStyle(
                fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 70, 0, 25),
            child: SizedBox(
                height: 170,
                width: 180,
                child: Image.asset('assets/images/emoti_informatico.png')),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 80, right: 80),
            child: Text(
              textAlign: TextAlign.center,
              'Una app para enterarse sobre conceptos, historias, fundadores, sugerencias, afirmaciones, tips, y curiosidades.',
              style: TextStyle(fontFamily: 'Inter'),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
