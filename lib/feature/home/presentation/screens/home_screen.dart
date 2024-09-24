import 'package:factos/core/config/ads/ads_factos.dart';
import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/core/common/drawer/presentation/widgets/drawer_widget.dart';
import 'package:factos/feature/home/presentation/widgets/facto_home_widget.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_filter_widget.dart';
import 'package:factos/feature/saved/presentation/screens/saved_factos.dart';
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
                    showCustomPreferenceDialog(context);
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

  void showCustomPreferenceDialog(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final preferences = [
      'Desarrollo Web',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Tips',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
    ];

    final categorias = [
      'categ1',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
      'Desarrollo Móvil',
      'Tips',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
    ];

    List<bool> selectedPreferences =
        List.generate(preferences.length, (index) => false);
    List<bool> selectedCategorias =
        List.generate(categorias.length, (index) => false);

    int currentPreferencePage = 0;
    int currentCategoriaPage = 0;

    showDialog(
      barrierColor: const Color.fromARGB(255, 13, 12, 12).withOpacity(0.7),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                AlertDialog(
                  backgroundColor: backgroundFilterDialog,
                  insetPadding: EdgeInsets.zero,
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: width * 0.89,
                    height: height * 0.50,
                    decoration: BoxDecoration(
                      color: backgroundFilterDialog,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Selecciona tus preferencias',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: PageView.builder(
                            itemCount: (preferences.length / 7).ceil(),
                            onPageChanged: (page) {
                              //TODO: las preferencias seleccionadas se iran a una nueva lista string a shp y en la bd antes de hacer el select generico se debe implementar la excepcion (elementos que no sean los de la lista)

                              setState(() {
                                currentPreferencePage = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              return buildPreferencePage(preferences, index,
                                  height, setState, selectedPreferences);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                          width: width * 0.8,
                          child: buildProgressIndicator(
                              preferences.length, currentPreferencePage),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Selecciona tus categorias',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: PageView.builder(
                            itemCount: (categorias.length / 7).ceil(),
                            onPageChanged: (page) {
                              setState(() {
                                currentCategoriaPage = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              return buildCategoriaPage(categorias, index,
                                  height, setState, selectedCategorias);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                          width: width * 0.8,
                          child: buildProgressIndicator(
                              categorias.length, currentCategoriaPage),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: height * 0.715,
                  left: width * 0.4,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          color: lightBackgroundTextColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Guardar'))),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildProgressIndicator(int totalItems, int currentPage) {
    int totalPages = (totalItems / 7).ceil();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: index == currentPage ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
        );
      }),
    );
  }

  Widget buildPreferencePage(List<String> preferences, int pageIndex,
      double height, StateSetter setState, List<bool> selectedPreferences) {
    int start = pageIndex * 7;
    int end = (start + 7 < preferences.length) ? start + 7 : preferences.length;

    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: preferences.getRange(start, end).map((category) {
            int index = preferences.indexOf(category);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPreferences[index] = !selectedPreferences[index];
                });
              },
              child: SizedBox(
                height: height * 0.04,
                child: FactosFilterWidget(
                  categoryName: category,
                  widgetSelected: selectedPreferences[index],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildCategoriaPage(List<String> categorias, int pageIndex,
      double height, StateSetter setState, List<bool> selectedCategorias) {
    int start = pageIndex * 7;
    int end = (start + 7 < categorias.length) ? start + 7 : categorias.length;

    return Column(
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: categorias.getRange(start, end).map((category) {
            int index = categorias.indexOf(category);
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategorias[index] = !selectedCategorias[index];
                });
              },
              child: SizedBox(
                height: height * 0.04,
                child: FactosFilterWidget(
                  categoryName: category,
                  widgetSelected: selectedCategorias[index],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
