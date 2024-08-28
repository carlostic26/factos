import 'package:factos/config/styles/constants/theme_data.dart';
import 'package:factos/presentation/screens/home/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
//metodo que conecta al caso de uso que me retorna todos los factos.

/*
 getLenguajesCategory(cat){
  return category('Lenguajes')}

   getHistoriaCategory(cat){
  return category('Lenguajes')}
*/

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
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
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
              ),
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
              Row(
                children: [
                  Column(
                    children: [
                      const Text('Titulo'),
                      const Text('Use  with the...'),
                      Row(
                        children: [
                          const Text('Fuente'),
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: IconButton(
                                iconSize: 15,
                                onPressed: () {},
                                icon: const Icon(Icons.visibility)),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: IconButton(
                                iconSize: 15,
                                onPressed: () {},
                                icon: const Icon(Icons.share)),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: IconButton(
                                iconSize: 15,
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_border)),
                          ),
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: IconButton(
                                iconSize: 15,
                                onPressed: () {},
                                icon: const Icon(Icons.delete)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset('assets/images/logo.png'))
                ],
              )
            ],
          )),
      drawer: const DrawerFactos(),
    );
  }
}
