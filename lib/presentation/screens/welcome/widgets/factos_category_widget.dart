import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FactosCategoryWidget extends StatelessWidget {
  final String categoryName;
  final bool widgetSelected;

  const FactosCategoryWidget({
    super.key,
    required this.categoryName,
    required this.widgetSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 32,
        padding: const EdgeInsets.only(left: 3),
        decoration: BoxDecoration(
          color: widgetSelected
              ? factoBackgroundColor
              : const Color.fromARGB(255, 68, 68, 68),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 25,
                padding: const EdgeInsets.all(5), // Espacio alrededor del icono
                decoration: const BoxDecoration(
                  color: tagBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/icon_code.svg',
                  height: 24.0,
                  width: 24.0,
                ),
              ),
              //const SizedBox(width: 10.0),
              Text(
                categoryName,
                style: const TextStyle(
                  color: lightBackgroundTextColor,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
