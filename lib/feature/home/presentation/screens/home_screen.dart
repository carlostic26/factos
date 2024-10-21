import 'package:factos/feature/home/presentation/screens_home_barrel.dart';
import '../widgets/header_home_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  BannerAd? _anchoredAdaptiveAd;
  bool isAdLoaded = false;
  bool isLoaded = false;

  String preferenceSelected = 'Historia';
  late SQLiteFactoLocalDatasourceImpl handler;
  List<String> categoriesNames = [];
  List<String> preferencesByDb = [];

  Future<List<FactoModel>>? _facto;

  bool isResultSearch = false;

  @override
  void initState() {
    super.initState();
    getPreferencesFactosBd();
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

  Future<List<FactoModel>> conectionPreferenceFactos() async {
    return await handler.getListPreferenceFacto(preferenceSelected);
  }

  Future<List<FactoModel>> conectionSearchedFactos(title) async {
    return await handler.getFactosListByWord(title);
  }

  Future<void> getPreferencesFactosBd() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listNamesPreferenceFactos = await conectionAllFactos();

      List<FactoModel> listPreferenceFactos = await conectionPreferenceFactos();

      setState(() {
        _facto = Future.value(listPreferenceFactos);

        preferencesByDb = listNamesPreferenceFactos
            .map((facto) => facto.preference)
            .where((category) => !category.contains(','))
            .toSet()
            .toList();
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? pagesChanged = prefs.getInt('counterChangePage');

      prefs.setInt('counterChangePage', pagesChanged! + 1);

      if (pagesChanged > 3) {
        listPreferenceFactos.shuffle();
        prefs.setInt('counterChangePage', 0);
      }
    });
  }

  Future<void> getPreferencesBySearchBarFactosBd(title) async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listNamesPreferenceFactos =
          await conectionSearchedFactos(title);

      List<FactoModel> listPreferenceFactos = await conectionPreferenceFactos();

      setState(() {
        _facto = Future.value(listPreferenceFactos);

        preferencesByDb = listNamesPreferenceFactos
            .map((facto) => facto.preference)
            .where((category) => !category.contains(','))
            .toSet()
            .toList();
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      int? pagesChanged = prefs.getInt('counterChangePage');

      prefs.setInt('counterChangePage', pagesChanged! + 1);

      if (pagesChanged > 3) {
        listPreferenceFactos.shuffle();
        prefs.setInt('counterChangePage', 0);
      }
    });
  }

  FactosAds ads = FactosAds();

  Future<void> _loadAdaptativeAd() async {
    if (isAdLoaded) {
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
          setState(() {
            _anchoredAdaptiveAd = ad as BannerAd;
            isLoaded = true;
          });
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final searchState = ref.watch(searchProvider);
    bool isResultSearch = searchState.isLoading;
    final isSearchBar = ref.watch(isSearchBarBoolean);
    final pageHomePreferenceController = PageController();

    bool pageChanged = false;

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
                    children: preferencesByDb.map((preference) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            getPreferencesFactosBd();

                            preferenceSelected = preference;
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
                ? SearchedBarFactos(searchState: searchState)
                : Expanded(
                    child: PageView(
                        controller: pageHomePreferenceController,
                        onPageChanged: (int page) {
                          pageChanged = true;
                          getPreferencesFactosBd();
                          preferenceSelected = preferencesByDb[page];
                        },
                        children: [
                          preferencesListFactos(facto: _facto),
                          for (int i = 0; i < preferencesByDb.length; i++)
                            preferencesListFactos(facto: _facto),
                        ]),
                  ),
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

  void buildWaitingPage(pageChanged) {
    if (!pageChanged) {}
  }

  PageController nextPage(pageController) {
    return pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
