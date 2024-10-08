import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:webview_flutter/webview_flutter.dart';

final loadingProvider = StateProvider<bool>((ref) => true);

final webViewControllerProvider =
    Provider.family<WebViewController, String>((ref, url) {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36')
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String loadingUrl) {
          ref.read(loadingProvider.notifier).state = true;
        },
        onPageFinished: (String url) {
          ref.read(loadingProvider.notifier).state = false;
        },
      ),
    )
    ..loadRequest(Uri.parse(url));
  return controller;
});
