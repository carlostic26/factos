import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

final adProvider = ChangeNotifierProvider<AdNotifier>((ref) => AdNotifier());

class AdNotifier extends ChangeNotifier {
  BannerAd? _anchoredAdaptiveAd;
  bool _isAdLoaded = false;

  BannerAd? get anchoredAdaptiveAd => _anchoredAdaptiveAd;
  bool get isAdLoaded => _isAdLoaded;

  FactosAds ads = FactosAds();

  Future<void> loadAdaptativeAd(BuildContext context) async {
    if (_isAdLoaded) {
      return;
    }

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      return;
    }

    BannerAd loadedAd = BannerAd(
      adUnitId: ads.bannerAd,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          _anchoredAdaptiveAd = ad as BannerAd;
          _isAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );

    try {
      await loadedAd.load();
    } catch (e) {
      loadedAd.dispose();
    }
  }
}
