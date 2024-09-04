import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/feature/home/presentation/screens/home/widgets/drawer_widget.dart';
import 'package:factos/feature/home/presentation/screens/home/widgets/facto_home_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/header_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? categorySelected;
  late SQLiteFactoLocalDatasourceImpl handler;
  List<String> categoriesNames = [];

  List<String> categoriesByDb = [];

  Future<List<FactoModel>>? _facto;

  @override
  void initState() {
    super.initState();
    categorySelected = 'Tips';
    getAllFactosBd();

    //getCategoryNames();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //getFactosByCategoryBd();
  }
/* 
  Future<List<FactoModel>> conectionListFactosByCategory() async {
    return await handler.getCategory(categorySelected);
  }

  Future<void> getFactosByCategoryBd() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> factosByCategory = await conectionListFactosByCategory();
      factosByCategory.shuffle();
      setState(() {
        _facto = Future.value(factosByCategory);
      });
    });
  } */

  Future<List<FactoModel>> conectionAllFactos() async {
    return await handler.getAllFactoList2();
  }

  Future<void> getAllFactosBd() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listAllFactos = await conectionAllFactos();
      listAllFactos.shuffle();
      setState(() {
        _facto = Future.value(listAllFactos);

        // Filtrar y extraer categorías únicas que no contengan comas
        categoriesByDb = listAllFactos
            .map((facto) => facto.category)
            .where((category) => !category.contains(','))
            .toSet()
            .toList();

        print('Categorias de la bd:  $categoriesByDb');
      });
    });
  }

  final Map<int, String> categories = {
    1: 'Desarrollo Web',
    2: 'Tips',
    3: 'Desarrollo Móvil',
    4: 'Habilidades',
    5: 'Inteligencia artificial',
    6: 'IoT',
    7: 'Sugerencias',
    8: 'Lenguajes',
    9: 'Desarrollo de escritorio',
    10: 'Motivacional',
    11: 'Desarrollo de videojuegos',
    12: 'Historia'
  };

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
                  onPressed: () {},
                  icon: const Icon(
                    size: 16,
                    Icons.tune,
                    color: Colors.white,
                  )),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categoriesByDb.map((category) {
                      return TextButton(
                        onPressed: () {
                          setState(() {
                            categorySelected = category;
                          });
                        },
                        child: Text(
                          category,
                          style: TextStyle(
                            color: titleTextColor,
                            fontFamily: 'Inter',
                            fontWeight: categorySelected == category
                                ? FontWeight.bold
                                : FontWeight.normal,
                            decoration: categorySelected == category
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
}
