import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsNotifier extends StateNotifier<AdsState> {
  AdsNotifier() : super(AdsState());

  Future<void> loadAdaptiveAd(BuildContext context) async {
    if (state.isAdLoaded) return;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) return;

    FactosAds ads = FactosAds();

    final BannerAd loadedAd = BannerAd(
      adUnitId: ads.bannerAd,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          state = state.copyWith(
            anchoredAdaptiveAd: ad as BannerAd,
            isLoaded: true,
            isAdLoaded: true,
          );
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

class AdsState {
  final BannerAd? anchoredAdaptiveAd;
  final bool isLoaded;
  final bool isAdLoaded;

  AdsState({
    this.anchoredAdaptiveAd,
    this.isLoaded = false,
    this.isAdLoaded = false,
  });

  AdsState copyWith({
    BannerAd? anchoredAdaptiveAd,
    bool? isLoaded,
    bool? isAdLoaded,
  }) {
    return AdsState(
      anchoredAdaptiveAd: anchoredAdaptiveAd ?? this.anchoredAdaptiveAd,
      isLoaded: isLoaded ?? this.isLoaded,
      isAdLoaded: isAdLoaded ?? this.isAdLoaded,
    );
  }
}

final adsProvider = StateNotifierProvider<AdsNotifier, AdsState>((ref) {
  return AdsNotifier();
});
