import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/feature/home/presentation/widgets/facto_home_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SavedFactos extends StatefulWidget {
  const SavedFactos({super.key});

  @override
  State<SavedFactos> createState() => _SavedFactosState();
}

class _SavedFactosState extends State<SavedFactos> {
  //initializing banner ad
  BannerAd? _anchoredAdaptiveAd;
  bool _isAdLoaded = false;
  bool _isLoaded = false;

  late SQLiteFactoLocalDatasourceImpl handler;
  Future<List<FactoModel>>? _facto;
  bool isFactos = false;

  @override
  void initState() {
    super.initState();
    getSavedFactosFromSharedPreferences();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  FactosAds ads = FactosAds();

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  Future<void> _loadAdaptativeAd() async {
    if (_isAdLoaded) {
      return;
    }

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
            MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      //print('Unable to get height of anchored banner.');
      return;
    }

    BannerAd loadedAd = BannerAd(
      adUnitId: ads.bannerAd,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // print('Anchored adaptive banner failedToLoad: $error');
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

  Future<List<FactoModel>> conectionSavedFactos() async {
    return await handler.getFactosListFromSharedPreferences();
  }

  Future<void> getSavedFactosFromSharedPreferences() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listSavedFactos = await conectionSavedFactos();

      setState(() {
        _facto = Future.value(listSavedFactos);

        if (_facto != null) {
          isFactos = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundGlobalColor,
      /*    appBar: AppBar(
        title: const Text(
          'Guardados',
          style: TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ), */
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Guardados',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            centerTitle: true,
            pinned: true,
            floating: false,
            backgroundColor: scaffoldBackgroundGlobalColor,
            foregroundColor: Colors.white,
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<FactoModel>>(
              future: _facto,
              builder: (BuildContext context,
                  AsyncSnapshot<List<FactoModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var itemFacto = snapshot.data ?? <FactoModel>[];
                  if (itemFacto.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aun no tienes factos guardados',
                        style: TextStyle(fontFamily: 'Inter'),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: itemFacto.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FactoHomeWidget(
                          title: itemFacto[index].title,
                          description: itemFacto[index].description,
                          nameFont: itemFacto[index].nameFont,
                          linkFont: itemFacto[index].linkFont,
                          linkImg: itemFacto[index].linkImg,
                          homeContext: context,
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _anchoredAdaptiveAd != null
          ? Container(
              color: Colors.transparent,
              width: _anchoredAdaptiveAd?.size.width.toDouble(),
              height: _anchoredAdaptiveAd?.size.height.toDouble(),
              child: AdWidget(ad: _anchoredAdaptiveAd!),
            )
          : const SizedBox(),
    );
  }
}
