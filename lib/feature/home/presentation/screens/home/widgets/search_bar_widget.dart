import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
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
                    fontSize: 12, color: Colors.grey, fontFamily: 'Inter'),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  size: 28,
                  Icons.tune,
                  color: Colors.grey,
                )),
          )
        ],
      ),
    );
  }
}
