import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';
import 'package:factos/feature/saved/presentation/screens/saved_factos.dart';
import 'package:factos/feature/webview/presentation/providers/loading_state_provider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailto/mailto.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends ConsumerWidget {
  final String? titleFacto;
  final String? descriptionFacto;
  final String urlSourceFacto;

  WebviewScreen({
    super.key,
    required this.titleFacto,
    required this.descriptionFacto,
    required this.urlSourceFacto,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkedTitles = ref.watch(bookmarkedTitlesProvider);
    final isBookmarked = bookmarkedTitles.contains(titleFacto);

    final isLoading = ref.watch(loadingProvider);
    final controller =
        ref.watch(webViewControllerProvider(urlSourceFacto ?? ''));
    double width = MediaQuery.of(context).size.width;

    void handleClick(String value) {
      switch (value) {
        case 'Abrir con el navegador':
          launchUrlFacto(urlSourceFacto!);
          break;
        case 'Guardar Facto':
          guardarFacto(ref, context);
          break;
        case 'Copiar enlace':
          copyLink();
          break;
        case 'Compartir mediante...':
          shareUrl();
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
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(
          titleFacto ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
            fontSize: 16,
          ),
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
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          if (isLoading)
            Expanded(
              child: Container(
                color: Colors.black87,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void copyLink() {
    Clipboard.setData(ClipboardData(text: urlSourceFacto!));
    Fluttertoast.showToast(
      msg: "Enlace copiado",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void shareUrl() {
    Share.share(
        '$descriptionFacto \n\nDescubre este y otros factos más usando la App Factos de Programación. Enlace a PlayStore aquí: url ');
  }

  List messageMail = ["", "", "", "", ""];
  late bool valPagCaida1 = false;
  late bool valPagCaida2 = false;
  late bool valPagCaida3 = false;
  late bool valPagCaida4 = false;

  bool errorNoCarga = false,
      errorNoEsElFacto = false,
      errorWebCaida = false,
      errorFaltanElementos = false;

  showDialogToReportProblem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SimpleDialog(children: [
              const Text(
                "¿Qué ha ocurrido?\n",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 1,
              ),
              CheckboxListTile(
                  title: const Text(
                    "La web no carga",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Inter',
                        color: lightBackgroundTextColor),
                  ),
                  value: (valPagCaida1),
                  onChanged: (val) => setState(() {
                        if (!errorNoCarga) {
                          messageMail[0] = ("\n- La web no carga\n");
                          errorNoCarga = true;
                        } else {
                          messageMail[0] = "";
                          errorNoCarga = false;
                        }
                        valPagCaida1 = val!;
                      })),
              CheckboxListTile(
                  title: const Text(
                    "La web no corresponde al Facto",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Inter',
                        color: lightBackgroundTextColor),
                  ),
                  value: (valPagCaida2),
                  onChanged: (val) => setState(() {
                        if (!errorNoEsElFacto) {
                          messageMail[1] =
                              ("\n- La web no corresponde al Facto.");
                          errorNoEsElFacto = true;
                        } else {
                          messageMail[1] = "";
                          errorNoEsElFacto = false;
                        }
                        valPagCaida2 = val!;
                      })),
              CheckboxListTile(
                  title: const Text(
                    "Página caida",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Inter',
                        color: lightBackgroundTextColor),
                  ),
                  value: (valPagCaida3),
                  onChanged: (val) => setState(() {
                        if (!errorWebCaida) {
                          messageMail[2] = ("\n- Página caida.\n");
                          errorWebCaida = true;
                        } else {
                          messageMail[2] = "";
                          errorWebCaida = false;
                        }
                        valPagCaida3 = val!;
                      })),
              CheckboxListTile(
                  title: const Text(
                    "No se aprecian algunos elementos",
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Inter',
                        color: lightBackgroundTextColor),
                  ),
                  value: (valPagCaida4),
                  onChanged: (val) => setState(() {
                        if (!errorFaltanElementos) {
                          messageMail[3] =
                              ("\n- No se aprecian algunos elementos");
                          errorFaltanElementos = true;
                        } else {
                          messageMail[3] = "";
                          errorFaltanElementos = false;
                        }
                        valPagCaida4 = val!;
                      })),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          lightBackgroundTextColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
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
        body:
            // ignore: prefer_interpolation_to_compose_strings
            "Quiero reportar un fallo de la app Factos en $titleFacto  \n\n " +
                messageMail[0] +
                messageMail[1] +
                messageMail[2] +
                messageMail[3]);

    final Uri url = Uri.parse(mailtoLink.toString());
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchUrlFacto(String urlFacto) async {
    if (await canLaunchUrl(Uri.parse(urlFacto))) {
      await launchUrl(Uri.parse(urlFacto));
    } else {
      throw 'Could not launch $urlFacto';
    }
  }

  void guardarFacto(WidgetRef ref, context) {
    ref.read(bookmarkedTitlesProvider.notifier).toggleBookmark(titleFacto!);

    showSavedFactoSnackBar(context);
  }

  void showSavedFactoSnackBar(BuildContext homeContext) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Facto guardado'),
          TextButton(
            onPressed: () {
              Navigator.push(
                homeContext,
                MaterialPageRoute(
                    builder: (homeContext) => const SavedFactos()),
              );
            },
            child: const Text(
              'Ver factos',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(homeContext).showSnackBar(snackBar);
  }
}
