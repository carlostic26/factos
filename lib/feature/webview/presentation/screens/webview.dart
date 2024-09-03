import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String url = 'https://www.google.com/';
    late WebViewController _controller;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36')
      ..loadRequest(Uri.parse(url)); //widget.urlCourse.toString()

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: width * 0.08,
          child: IconButton(
              onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
        ),
        title: const Text(
          'Lenguajes - Un dia como hoy...',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 16),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: width * 0.08,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.08,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.public,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
