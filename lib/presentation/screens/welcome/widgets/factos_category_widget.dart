import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FactosCategoryWidget extends StatelessWidget {
  const FactosCategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2),
      child: Container(
        height: 30,
        width: 200,
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: factoBackgroundColor,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/icon_code.svg',
              height: 24.0,
              width: 24.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Tu texto aquí',
              style: TextStyle(
                color: lightBackgroundTextColor,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
