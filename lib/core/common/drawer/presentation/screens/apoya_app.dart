import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:flutter/material.dart';

class ApoyaApp extends StatefulWidget {
  const ApoyaApp({super.key});

  @override
  State<ApoyaApp> createState() => _ApoyaAppState();
}

class _ApoyaAppState extends State<ApoyaApp> {
  //TODO: Instanciacion de los anuncios

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Apóyanos',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Text(
              'Con tu ayuda podemos aumentar la cantidad de Factos de Programación para que te enteres de todos los datos relacionados a tu sector Tech. Te tomará solo unos segundos.',
              style: TextStyle(fontFamily: 'Inter'),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              height: 300,
              width: 370,
              child: Image.network(
                  fit: BoxFit.fill,
                  'https://media3.giphy.com/media/FPF3LQS9qAYxyEHSql/200w.gif?cid=6c09b952ljxvmu5lsaiztlds24oqfakwbouu3wyovgu2gcxz&ep=v1_videos_related&rid=200w.gif&ct=v'),
            ),
            SizedBox(
              height: 100,
            ),
            TextButton(
                onPressed: () {
                  //TODO: show intertitial ad
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const SizedBox(
                    width: 180,
                    height: 30,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.visibility,
                            color: Colors.white,
                          ),
                          Text(
                            '  Ver un anuncio',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
