import 'package:flutter/material.dart';

class WelcomeThirdPage extends StatelessWidget {
  const WelcomeThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        const Center(
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
        const Expanded(
          child: SizedBox(),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            iconSize: 30,
            onPressed: () {
              //TODO: Go to next page
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
