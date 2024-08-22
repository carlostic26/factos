import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class FactoWidget extends StatelessWidget {
  const FactoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: 140,
          width: 280,
          decoration: BoxDecoration(
            color: factoBackgroundColor,
            borderRadius: BorderRadius.circular(33),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  'Un dia como hoy...',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: lightBackgroundTextColor),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style:
                      TextStyle(fontSize: 10, color: lightBackgroundTextColor),
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }
}
