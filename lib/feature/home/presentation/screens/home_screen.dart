import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/core/common/drawer/presentation/widgets/drawer_widget.dart';
import 'package:factos/feature/home/presentation/widgets/custom_interest_dialog.dart';
import 'package:factos/feature/home/presentation/widgets/facto_home_widget.dart';
import 'package:factos/feature/launch/presentation/provider/category_selected_provider.dart';
import 'package:factos/feature/launch/presentation/provider/interests_user_provider.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_filter_widget.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_fifth_widget_preferences.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_fourth_widget_categories.dart';
import 'package:factos/feature/search/presentation/provider/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../widgets/header_home_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  //initializing banner ad
  BannerAd? _anchoredAdaptiveAd;
  bool _isAdLoaded = false;
  bool _isLoaded = false;

  String preferenceSelected = 'Historia';
  late SQLiteFactoLocalDatasourceImpl handler;
  List<String> categoriesNames = [];
  List<String> categoriesByDb = [];

  Future<List<FactoModel>>? _facto;

  bool isResultSearch = false;

  @override
  void initState() {
    super.initState();
    getCategoryFactosBd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAdaptativeAd();
  }

  static const AdRequest request = AdRequest(
      //keywords: ['',''],
      //contentUrl: '',
      //nonPersonalizedAds: false
      );

  Future<List<FactoModel>> conectionAllFactos() async {
    return await handler.getAllFactoList();
  }

/*   Future<void> getAllFactosBd() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listAllFactos = await conectionAllFactos();
      listAllFactos.shuffle();
      setState(() {
        _facto = Future.value(listAllFactos);

        categoriesByDb = listAllFactos
            .map((facto) => facto.category)
            .where((category) => !category.contains(','))
            .toSet()
            .toList();

        print('Categorias de la bd:  $categoriesByDb');
      });
    });
  }
  */
  Future<List<FactoModel>> conectionPreferenceFactos() async {
    return await handler.getListPreferenceFacto(preferenceSelected);
  }

  Future<void> getCategoryFactosBd() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listNamesPreferenceFactos = await conectionAllFactos();

      List<FactoModel> listPreferenceFactos = await conectionPreferenceFactos();
      listPreferenceFactos.shuffle();
      setState(() {
        _facto = Future.value(listPreferenceFactos);

        categoriesByDb = listNamesPreferenceFactos
            .map((facto) => facto.preference)
            .where((category) => !category.contains(','))
            .toSet()
            .toList();

        print('Categorias de la bd:  $categoriesByDb');
      });
    });
  }

  FactosAds ads = FactosAds();

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final searchState = ref.watch(searchProvider);
    bool isResultSearch = searchState.isLoading;

    final isSearchBar = ref.watch(isSearchBarBoolean);

    return Scaffold(
      backgroundColor: scaffoldBackgroundGlobalColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: scaffoldBackgroundGlobalColor,
        centerTitle: true,
        title: const Text(
          'Factos',
          style: TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          HeaderWidget(
            height: height,
            isResultSearch: isResultSearch,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          //category controller
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    const CustomInterestDialog().show(context);
                  },
                  icon: const Icon(
                    size: 16,
                    Icons.tune,
                    color: Colors.white,
                  )),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoriesByDb.map((preference) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            getCategoryFactosBd();

                            preferenceSelected = preference;

                            print('PREFERENCE S: $preferenceSelected \n');
                            print('PREFERENCE: $preference \n');
                          });
                        },
                        child: Text(
                          preference,
                          style: TextStyle(
                            color: titleTextColor,
                            fontFamily: 'Inter',
                            fontWeight: preferenceSelected == preference
                                ? FontWeight.bold
                                : FontWeight.normal,
                            decoration: preferenceSelected == preference
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: isSearchBar
                ? FutureBuilder<List<FactoModel>>(
                    future: Future.value(searchState.searchResults),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<FactoModel>> snapshot) {
                      if (searchState.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (searchState.error != null) {
                        return Center(
                            child: Text('Error: ${searchState.error}'));
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        var itemFacto = snapshot.data ?? <FactoModel>[];

                        if (itemFacto.isEmpty) {
                          return const Center(
                            child: Text(
                              'No se encontró ningún facto',
                              style: TextStyle(fontFamily: 'Inter'),
                            ),
                          );
                        } else {
                          return ListView.builder(
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
                  )
                : FutureBuilder<List<FactoModel>>(
                    future: _facto,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<FactoModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        var itemFacto = snapshot.data ?? <FactoModel>[];

                        if (itemFacto.isEmpty) {
                          return const Center(
                            child: Text(
                              'No se encontró ningun facto',
                              style: TextStyle(fontFamily: 'Inter'),
                            ),
                          );
                        } else {
                          return ListView.builder(
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
                    }),
          ),
        ],
      ),
      drawer: DrawerFactosWidget(
        context: context,
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
