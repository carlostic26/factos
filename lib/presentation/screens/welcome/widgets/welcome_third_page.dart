import 'package:flutter/material.dart';

class WelcomeThirdPage extends StatelessWidget {
  const WelcomeThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Text('Comencemos personalizando tus intereses',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
