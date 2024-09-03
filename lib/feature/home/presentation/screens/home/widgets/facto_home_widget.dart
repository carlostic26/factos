import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class FactoHomeWidget extends StatelessWidget {
  final String title;
  final String description;
  final String linkFont;
  final String linkImg;

  const FactoHomeWidget({
    super.key,
    required this.title,
    required this.description,
    required this.linkFont,
    required this.linkImg,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            height: 0.9),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 6,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Inter',
                            fontSize: 12,
                            height: 1.2),
                      ),
                      const Spacer(),
                      const SizedBox(
                        height: 14,
                      ),
                      SizedBox(
                        height: 18,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              linkFont,
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: subtitleTextColor),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    width: 21,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: subtitleTextColor,
                                      iconSize: 18,
                                      icon: const Icon(Icons.visibility),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 21,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: subtitleTextColor,
                                      iconSize: 18,
                                      icon: const Icon(Icons.share),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 21,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: subtitleTextColor,
                                      iconSize: 18,
                                      icon: const Icon(Icons.bookmark_border),
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 21,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      color: subtitleTextColor,
                                      iconSize: 18,
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 2),
              SizedBox(
                child: Center(
                  child: Image.network(
                    width: 150,
                    height: 190,
                    linkImg,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
