import 'package:factos/feature/home/presentation/screens/home_screen.dart';
import 'package:factos/feature/saved/presentation/screens_saved_barrel.dart';

class SavedFactos extends StatefulWidget {
  const SavedFactos({super.key});

  @override
  State<SavedFactos> createState() => _SavedFactosState();
}

class _SavedFactosState extends State<SavedFactos> {
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
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: scaffoldBackgroundGlobalColor,
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
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: heightScreen * 0.35),
                          const Text(
                            'Aun no tienes factos guardados.',
                            style: TextStyle(fontFamily: 'Inter'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => (const HomeScreen())));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                            ),
                            child: const Text(
                              'Ver Factos',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ],
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
                          facto: itemFacto[index],
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
