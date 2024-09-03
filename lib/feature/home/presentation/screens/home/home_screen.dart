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

  Future<List<FactoModel>>? _facto;

  @override
  void initState() {
    super.initState();
    categorySelected = 'Tips';
    setCategory();
  }

  Future<List<FactoModel>> getFactos() async {
    return await handler.getAllFactoList2();
  }

  Future<void> setCategory() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> list = await getFactos();
      list.shuffle();
      setState(() {
        _facto = Future.value(list);

        // Imprimir los datos en la consola
        print('ESTE ES EL PRINT DE NUESTROS FACTOS:');
        for (var facto in list) {
          print(facto); // Ajusta según tu modelo
        }
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 15, right: 10),
        child: Column(
          children: [
            HeaderWidget(height: height),
            SizedBox(
              height: height * 0.02,
            ),
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
                        children: categories.entries.map((entry) {
                          return TextButton(
                            onPressed: () {
                              setState(() {
                                categorySelected = entry.value;
                              });
                            },
                            child: Text(
                              entry.value,
                              style: TextStyle(
                                color: titleTextColor,
                                fontFamily: 'Inter',
                                fontWeight: categorySelected == entry.value
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                decoration: categorySelected == entry.value
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                              ),
                            ),
                          );
                        }).toList(),
                      )),
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
                              linkFont: itemFacto[index].linkFont,
                              linkImg: itemFacto[index].linkImg);
                        },
                      );
                    }
                  }),
            ),

            /*   Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: const [
                  FactoHomeWidget(
                    title: 'Titulo facto',
                    description:
                        'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                    source: 'Harvard',
                    imagePath: '',
                  ),
                  FactoHomeWidget(
                    title: 'Titulo facto',
                    description:
                        'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                    source: 'Harvard',
                    imagePath: '',
                  ),
                  FactoHomeWidget(
                    title: 'Titulo facto',
                    description:
                        'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                    source: 'Harvard',
                    imagePath: '',
                  ),
                  FactoHomeWidget(
                    title: 'Titulo facto',
                    description:
                        'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                    source: 'Harvard',
                    imagePath: '',
                  ),
                  FactoHomeWidget(
                    title: 'Titulo facto',
                    description:
                        'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                    source: 'Harvard',
                    imagePath: '',
                  ),
                ],
              ),
            )
          
           */
          ],
        ),
      ),
      drawer: DrawerFactosWidget(
        context: context,
      ),
      bottomNavigationBar: const SizedBox(height: 70, child: Placeholder()),
    );
  }
}
