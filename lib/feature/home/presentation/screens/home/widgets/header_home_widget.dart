import 'package:factos/feature/home/presentation/screens/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Explorar',
            style: TextStyle(
                height: 1.2,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 35),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            'Busca cualquier facto por palabra clave',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        const SearchBarWidget(),
      ],
    );
  }
}
