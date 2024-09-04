import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class FactoHomeWidget extends StatelessWidget {
  final String title;
  final String description;
  final String nameFont;
  final String linkFont;
  final String linkImg;

  const FactoHomeWidget({
    super.key,
    required this.title,
    required this.description,
    required this.nameFont,
    required this.linkFont,
    required this.linkImg,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.transparent,
      //elevation: 4,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 0.9),
                        ),
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
                      SizedBox(
                        height: height * 0.01,
                      ),
                      SizedBox(
                        height: height * 0.025,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.24,
                              child: Text(
                                nameFont,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: subtitleTextColor,
                                  height: 1,
                                ),
                                maxLines:
                                    2, // Establece el máximo de líneas a 2
                                overflow: TextOverflow
                                    .ellipsis, // Mostrará los puntos suspensivos si aún se desborda
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      width: width * 0.05,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: subtitleTextColor,
                                        iconSize: 18,
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: subtitleTextColor,
                                        iconSize: 18,
                                        icon: const Icon(Icons.share),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: subtitleTextColor,
                                        iconSize: 18,
                                        icon: const Icon(Icons.bookmark_border),
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.35,
                height: height * 0.2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    linkImg,
                    width: width * 0.35,
                    height: height * 0.2,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
