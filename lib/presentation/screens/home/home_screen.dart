import 'package:factos/presentation/screens/home/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    IconButton(onPressed: () {}, icon: Icon(Icons.tune))
                  ],
                ),
              )
            ],
          )),
      drawer: const DrawerFactos(),
    );
  }
}
