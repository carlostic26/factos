import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExampleFactoWidget extends StatelessWidget {
  ExampleFactoWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.font});

  String title;
  String subtitle;
  String font;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(children: [
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: height * 0.18,
          width: width * 0.75,
          decoration: BoxDecoration(
            color: factoBackgroundColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      color: lightBackgroundTextColor),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 10,
                        color: lightBackgroundTextColor,
                        fontFamily: 'Inter'),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          font,
                          style: const TextStyle(
                              fontSize: 8,
                              color: lightBackgroundTextColor,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                                onTap: () {
                                  print('ver');
                                },
                                child:
                                    const Icon(Icons.travel_explore, size: 15)),
                            InkWell(
                                onTap: () {},
                                child: const Icon(Icons.share, size: 15)),
                            InkWell(
                                onTap: () {},
                                child: const Icon(Icons.bookmark_border,
                                    size: 15)),
                            InkWell(
                                onTap: () {},
                                child: const Icon(Icons.delete, size: 15)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: height * 0.02,
        right: width * 0.02,
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
