import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 10),
      child: Column(
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
          Container(
            height: height * 0.05,
            decoration: BoxDecoration(
              color: searchFieldBackgroundColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      size: 28,
                      Icons.search,
                      color: Colors.grey,
                    )),
                const Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.yellow),
                    decoration: InputDecoration(
                      hintText: 'Python',
                      hintStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Inter'),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
