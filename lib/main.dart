import 'dart:math';

import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

AppOpenAd? openAd;
bool isAdLoaded = false;

Future<void> loadOpenAd() async {
  FactosAds ads = FactosAds();
  try {
    await AppOpenAd.load(
      adUnitId: ads.openAd,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          openAd = ad;

          int randomValue = Random().nextInt(2);

          print('numero random: $randomValue');

          if (randomValue == 1) {
            openAd!.show();
          }

          isAdLoaded = true;
        },
        onAdFailedToLoad: (error) {
          isAdLoaded = false;
        },
      ),
      orientation: AppOpenAd.orientationPortrait,
    );
  } catch (e) {
    print('Error loading open ad: $e');
    isAdLoaded = false;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();

  //crear metodo random entre 1 y 0, si cae 1 se muestra el openAd
  await loadOpenAd();

  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Factos',
      theme: factosThemeApp,
      home: const LoadingScreen(),
    ),
  ));
}
