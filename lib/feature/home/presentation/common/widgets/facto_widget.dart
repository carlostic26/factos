import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FactoWidget extends StatelessWidget {
  const FactoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(30.0),
        child: Container(
          height: height * 0.15,
          width: width * 0.70,
          decoration: BoxDecoration(
            color: factoBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  textAlign: TextAlign.start,
                  'Un dia como hoy...',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: lightBackgroundTextColor),
                ),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna ',
                  style: TextStyle(
                      fontSize: 12,
                      color: lightBackgroundTextColor,
                      fontFamily: 'Inter'),
                ),
                const Text(
                  'Lorem ipsum',
                  style: TextStyle(
                      fontSize: 8,
                      color: lightBackgroundTextColor,
                      fontFamily: 'Inter'),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                            iconSize: 15,
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                            iconSize: 15,
                            onPressed: () {},
                            icon: const Icon(Icons.share)),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                            iconSize: 15,
                            onPressed: () {},
                            icon: const Icon(Icons.bookmark_border)),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: IconButton(
                            iconSize: 15,
                            onPressed: () {},
                            icon: const Icon(Icons.delete)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: 25,
        right: 25,
        child: CircleAvatar(
          radius: 18,
          backgroundColor: tagBackgroundColor,
          child: SvgPicture.asset(
            'assets/icons/icon_code.svg',
            height: 25,
            width: 25,
            color: Colors.black87,
          ),
        ),
      ),
    ]);
  }
}
