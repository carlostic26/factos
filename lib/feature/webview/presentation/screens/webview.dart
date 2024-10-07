import 'package:factos/feature/home/presentation/screens/home_screen.dart';
import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatelessWidget {
  String? titleFacto;
  String? descriptionFacto;
  String? urlSourceFacto;
  WebviewScreen(
      {super.key,
      required this.titleFacto,
      required this.descriptionFacto,
      this.urlSourceFacto});

  @override
  Widget build(BuildContext context) {
    late WebViewController _controller;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
          'Mozilla/5.0 (Linux; Android 11; Pixel 5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.91 Mobile Safari/537.36')
      ..loadRequest(Uri.parse(urlSourceFacto!));

    void handleClick(String value) {
      switch (value) {
        case 'Abrir con el navegador':
          launchUrlFacto(urlSourceFacto!);
          break;
        case 'Guardar Facto':
          //guardarFacto();
          break;
        case 'Copiar enlace':
          copiarEnlace();
          break;
        case 'Compartir mediante...':
          compartirUrl();
          break;
        case 'Reportar fallo':
          showDialogToReportProblem(context);
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(
          width: width * 0.08,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
        ),
        title: Text(
          '$titleFacto',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Inter', fontSize: 16),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            iconSize: 20,
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {
                'Abrir con el navegador',
                'Guardar Facto',
                'Copiar enlace',
                'Compartir mediante...',
                'Reportar fallo'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  value: choice,
                  child: Text(
                    choice,
                    style: const TextStyle(color: Colors.black),
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  void copiarEnlace() {
    Clipboard.setData(ClipboardData(text: urlSourceFacto!));
    Fluttertoast.showToast(
      msg: "Enlace copiado",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void compartirUrl() {
    Share.share(
        '$descriptionFacto \n\nDescubre este y otros factos más usando la App Factos de Programación. Enlace a PlayStore aquí: url ');
  }

  List messageMail = ["", "", "", "", ""];
  late bool valPagCaida1 = false;
  late bool valPagCaida2 = false;
  late bool valPagCaida3 = false;
  late bool valPagCaida4 = false;
  late bool valPagCaida5 = false;

  bool errorLinkCaido = false,
      errorNoAds = false,
      errorCursoIncorrecto = false,
      errorNoPlayVideo = false,
      errorPideCobro = false;

  showDialogToReportProblem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(children: [
              const Text(
                "¿Qué ha ocurrido?\n",
                style: TextStyle(color: Colors.blue, fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 1,
              ),
              CheckboxListTile(
                  title: const Text(
                    "La página web no carga.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida1),
                  onChanged: (val) => setState(() {
                        if (!errorLinkCaido) {
                          messageMail[0] = ("\n- La página web no carga.\n");
                          errorLinkCaido = true;
                        } else {
                          messageMail[0] = "";
                          errorLinkCaido = false;
                        }
                        valPagCaida1 = valPagCaida1;
                      })),
              CheckboxListTile(
                  title: const Text(
                    "La página no corresponde al Facto.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida3),
                  onChanged: (val) => setState(() {
                        if (!errorNoPlayVideo) {
                          messageMail[2] =
                              ("\n- La página no corresponde al Facto.");
                          errorNoPlayVideo = true;
                        } else {
                          messageMail[2] = "";
                          errorNoPlayVideo = false;
                        }
                        valPagCaida3 = val!;
                      })),
              CheckboxListTile(
                  title: const Text(
                    "Página caida.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida4),
                  onChanged: (val) => setState(() {
                        if (!errorCursoIncorrecto) {
                          messageMail[3] = ("\n- Página caida.\n");
                          errorCursoIncorrecto = true;
                        } else {
                          messageMail[3] = "";
                          errorCursoIncorrecto = false;
                        }
                        valPagCaida4 = val!;
                      })),
              CheckboxListTile(
                  title: const Text(
                    "No se aprecian algunos elementos.",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  value: (valPagCaida5),
                  onChanged: (val) => setState(() {
                        if (!errorPideCobro) {
                          messageMail[4] =
                              ("\n- No se aprecian algunos elementos.");
                          errorPideCobro = true;
                        } else {
                          messageMail[4] = "";
                          errorPideCobro = false;
                        }
                        valPagCaida5 = val!;
                      })),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                            color: Colors.blueAccent,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Reportar',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    onPressed: () {
                      _mailto();
                    }),
              ),
            ]);
          });
        });
  }

  Future _mailto() async {
    final mailtoLink = Mailto(
      to: ['ticnoticos@gmail.com'],
      cc: [''],
      subject: 'Factos - Reporte de fallo',
      // ignore: prefer_interpolation_to_compose_strings
      body: "Quiero reportar un fallo de la app Factos: \n\n $titleFacto" +
          messageMail[0] +
          messageMail[1] +
          messageMail[2] +
          messageMail[3] +
          messageMail[4],
    );

    launchUrlFacto(mailtoLink as String);
  }

  void launchUrlFacto(String urlFacto) async {
    final Uri url = Uri.parse(urlFacto.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
