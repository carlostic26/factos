import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingProvider = StateProvider<bool>((ref) => true);
final errorProvider = StateProvider<bool>((ref) => false);

final webViewControllerProvider =
    Provider.family<WebViewController, String>((ref, url) {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36')
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String loadingUrl) {
          ref.read(loadingProvider.notifier).state = true; // Activa el loading
          ref.read(errorProvider.notifier).state =
              false; // Reinicia el estado de error
        },
        onPageFinished: (String url) {
          ref.read(loadingProvider.notifier).state =
              false; // Desactiva el loading
        },
        onWebResourceError: (WebResourceError error) {
          print('WebView error: ${error.description}');

          // Verifica si el error es de conexión rechazada
          if (error.description.contains('ERR_CONNECTION_REFUSED')) {
            ref.read(loadingProvider.notifier).state =
                false; // Desactiva el loading
            ref.read(errorProvider.notifier).state =
                true; // Activa el estado de error
          }
        },
      ),
    )
    ..loadRequest(Uri.parse(url));
  return controller;
});
