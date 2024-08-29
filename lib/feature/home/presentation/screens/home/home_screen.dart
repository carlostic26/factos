import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/presentation/screens/home/widgets/drawer_widget.dart';
import 'package:factos/feature/home/presentation/screens/home/widgets/facto_home_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? categorySelected;

  @override
  void initState() {
    super.initState();
    categorySelected = 'Lenguajes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Factos',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const Text(
                'Explorar',
                style: TextStyle(
                    height: 1.2,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
              ),
              const Text(
                'Busca cualquier facto por palabra clave',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  height: 1.2,
                ),
              ),
              const SearchBarWidget(),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.tune,
                        color: Colors.white,
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Lenguajes',
                                  style: TextStyle(
                                    color: titleTextColor,
                                    fontFamily: 'Inter',
                                    fontWeight: categorySelected! == 'Lenguajes'
                                        // ignore: dead_code
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Iot',
                                style: TextStyle(
                                  color: titleTextColor,
                                  fontFamily: 'Inter',
                                  fontWeight: categorySelected! == 'Lenguajes'
                                      // ignore: dead_code
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Historia',
                                style: TextStyle(
                                  color: titleTextColor,
                                  fontFamily: 'Inter',
                                  fontWeight: categorySelected! == 'Lenguajes'
                                      // ignore: dead_code
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'IA',
                                style: TextStyle(
                                  color: titleTextColor,
                                  fontFamily: 'Inter',
                                  fontWeight: categorySelected! == 'Lenguajes'
                                      // ignore: dead_code
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const FactoHomeWidget(
                title: 'Titulo facto',
                description:
                    'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                source: 'Harvard',
                imagePath: '',
              ),
              const FactoHomeWidget(
                title: 'Titulo facto',
                description:
                    'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                source: 'Harvard',
                imagePath: '',
              ),
              const FactoHomeWidget(
                title: 'Titulo facto',
                description:
                    'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                source: 'Harvard',
                imagePath: '',
              ),
              const FactoHomeWidget(
                title: 'Titulo facto',
                description:
                    'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                source: 'Harvard',
                imagePath: '',
              ),
              const FactoHomeWidget(
                title: 'Titulo facto',
                description:
                    'This is an image that provides texto from an error Image provider: AssetImage la (bundle: null, name: "") Image key: Asset Bundle Image Key( bundle: PlatformAsset Bundle#ad852(), name: "", scale : 1.0)',
                source: 'Harvard',
                imagePath: '',
              ),
            ],
          )),
      drawer: const DrawerFactos(),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          const Expanded(
            child: TextField(
              style: TextStyle(color: Colors.yellow),
              decoration: InputDecoration(
                hintText: 'python',
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune))
        ],
      ),
    );
  }
}
