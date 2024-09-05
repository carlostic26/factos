import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/feature/home/presentation/screens/home/widgets/drawer_widget.dart';
import 'package:factos/feature/home/presentation/screens/home/widgets/facto_home_widget.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/factos_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/header_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String preferenceSelected = 'Historia';
  late SQLiteFactoLocalDatasourceImpl handler;
  List<String> categoriesNames = [];

  List<String> categoriesByDb = [];

  Future<List<FactoModel>>? _facto;

  @override
  void initState() {
    super.initState();
    //getAllFactosBd();

    getCategoryFactosBd();
  }

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
          HeaderWidget(height: height),
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
                            preferenceSelected = preference;
                            print('MI PREFERENCIA ES: $preferenceSelected');
                            Fluttertoast.showToast(
                                gravity: ToastGravity.CENTER,
                                msg: 'Categoria actual: $preferenceSelected');

                            getCategoryFactosBd();
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
            //si preferenceSelected = 'Historia' entonces mostrar el _facto de historia, y asi con cada preference diferente
            child: FutureBuilder<List<FactoModel>>(
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

                    return ListView.builder(
                      itemCount: itemFacto.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FactoHomeWidget(
                            title: itemFacto[index].title,
                            description: itemFacto[index].description,
                            nameFont: itemFacto[index].nameFont,
                            linkFont: itemFacto[index].linkFont,
                            linkImg: itemFacto[index].linkImg);
                      },
                    );
                  }
                }),
          ),
        ],
      ),
      drawer: DrawerFactosWidget(
        context: context,
      ),
      bottomNavigationBar: const SizedBox(height: 70, child: Placeholder()),
    );
  }

  void showCustomPreferenceDialog(BuildContext context) {
    // Lista de nombres de categorías
    final preferences = [
      'Desarrollo Web',
      'Tips',
      'Desarrollo Móvil',
      'Habilidades',
      'Inteligencia artificial',
      'IoT',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                color: appbarBackgroundGlobalColor,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Selecciona tus preferencias',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 1,
                    runSpacing: 10,
                    alignment: WrapAlignment.center,
                    children: preferences.map((category) {
                      return SizedBox(
                        height: 10,
                        width: 160,
                        child: FactosCategoryWidget(
                          categoryName: category,
                          widgetSelected: true,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
