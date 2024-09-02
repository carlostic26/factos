import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  const WebviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String url = 'https://www.google.com/';
    late WebViewController _controller;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36')
      ..loadRequest(Uri.parse(url)); //widget.urlCourse.toString()

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_ios)),
        title: Text('title'),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.share),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.public),
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
