import 'package:factos/core/common/app_config.dart';
import 'package:factos/core/common/drawer/presentation/screens/apoya_app.dart';
import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/widgets/welcome_second_page_facto_card.dart';
import 'package:factos/feature/saved/presentation/screens/saved_factos.dart';
import 'package:factos/feature/search/presentation/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerFactosWidget extends StatelessWidget {
  BuildContext? context;
  DrawerFactosWidget({super.key, required context});

  AppConfig infoApp = AppConfig();

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;

    return Drawer(
      width: widthScreen * 0.75,
      backgroundColor: appbarBackgroundGlobalColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: buttonNoLigthColor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: heightScreen * 0.08,
                  width: widthScreen * 0.18,
                ),
                const SizedBox(height: 2),
                Text(
                  infoApp.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  infoApp.version,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Buscar'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Factos guardados'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SavedFactos()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.volunteer_activism),
            title: const Text('Apoya la app'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const ApoyaApp()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('¿Qué es un facto?'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Stack(
                            children: [
                              Container(
                                color: appbarBackgroundGlobalColor,
                              ),
                              const WelcomeFactoCardSecondPage(),
                              Positioned(
                                  left: 6,
                                  top: 18,
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back))),
                            ],
                          )));
            },
          ),
          SizedBox(
            height: heightScreen * 0.05,
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Información',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Inter'),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Info de la app'),
            onTap: () {
              dialogVersion(context, 'Información',
                  '${infoApp.name} es una app desarrollada por TICnoticos para mostrar y evidenciar datos interesantes sobre el amplio mundo de la informática y la Programación. \n\nVersión: ${infoApp.version}');
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Política de Privacidad'),
            onTap: () {
              _launchUrlPolicyPrivacy();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialogVersion(BuildContext context, title, description) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: appbarBackgroundGlobalColor,
          title: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
                  child: Text(textAlign: TextAlign.center, description),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.black12),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _launchUrlPolicyPrivacy() async {
    final Uri url = Uri.parse(
        'https://www.privacypolicies.com/live/4417a2dc-ecb0-4001-98eb-87e74ecb3e23');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo lanzar la URL $url';
    }
  }
}
