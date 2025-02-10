import 'package:factos/core/common/drawer/presentation/screens_drawer_barrel.dart';
import 'package:factos/feature/home/presentation/screens_home_barrel.dart';
import 'package:http/http.dart' as http;

class FactoHomeWidget extends ConsumerWidget {
  final String title;
  final String description;
  final String nameFont;
  final String linkFont;
  final String linkImg;
  final BuildContext? homeContext;
  final FactoModel facto;

  const FactoHomeWidget({
    super.key,
    required this.title,
    required this.description,
    required this.nameFont,
    required this.linkFont,
    required this.linkImg,
    required this.facto,
    this.homeContext,
  });

/*   Future<void> launchUrlFacto(String url, BuildContext context) async {
    // Simula la lógica de abrir la URL
    await Future.delayed(const Duration(seconds: 2)); // Simula una carga de 2 segundos
    final Uri url = Uri.parse(url);

    try {
      final response = await http.head(url);
      if (response.statusCode == 200) {
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          _showMaintenanceDialog(context);
        }
      } else {
        _showMaintenanceDialog(context);
      }
    } catch (e) {
      _showMaintenanceDialog(context);
    }
  } */

  Future<void> launchUrlFacto(String urlFacto, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    final Uri url = Uri.parse(urlFacto);

    try {
      // Verifica si la URL es accesible
      final response = await http
          .head(url); // Usa HEAD para verificar sin descargar el contenido
      if (response.statusCode == 200) {
        // Si la URL es accesible, ábrela en el navegador externo
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          // Si no se puede abrir la URL, muestra un diálogo
          _showMaintenanceDialog(context);
        }
      } else {
        // Si la URL no es accesible, muestra un diálogo
        _showMaintenanceDialog(context);
      }
    } catch (e) {
      // Maneja errores de conexión u otros errores
      _showMaintenanceDialog(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final bookmarkedTitles = ref.watch(bookmarkedTitlesProvider);
    final isBookmarked = bookmarkedTitles.contains(title);

    void handleClick(String value) {
      switch (value) {
        case 'Ver info completa':
          openWebviewUrlFacto(
              facto.linkFont, context, facto.title, facto.description);
          break;
        case 'Guardar':
          saveFacto(ref, isBookmarked);
          break;
        case 'Compartir mediante...':
          shareUrl(facto.description);
          break;
        case 'Dejar de ver':
          sendFactoToBlackList(facto.title);
          break;
      }
    }

    return Card(
      color: Colors.transparent,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 0.9),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 7,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontFamily: 'Inter',
                            fontSize: 10,
                            height: 1.2),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      SizedBox(
                        height: height * 0.025,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * 0.24,
                              child: Text(
                                nameFont,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 8,
                                  color: subtitleTextColor,
                                  height: 1,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Spacer(),
                                    SizedBox(
                                      width: width * 0.05,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: subtitleTextColor,
                                        iconSize: 18,
                                        icon: const Icon(Icons.visibility),
                                        onPressed: () {
                                          watchFactoDialog(context, facto);
                                        },
                                      ),
                                    ),
                                    StatefulBuilder(
                                      builder: (context, setState) {
                                        bool _isLoading = false;

                                        Future<void>
                                            _launchUrlWithLoading() async {
                                          setState(() {
                                            _isLoading =
                                                true; // Activa el loading
                                          });

                                          // Ejecuta la lógica de launchUrlFacto
                                          await launchUrlFacto(
                                              linkFont, context);

                                          setState(() {
                                            _isLoading =
                                                false; // Desactiva el loading
                                          });
                                        }

                                        return SizedBox(
                                          width: width * 0.05,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            color: subtitleTextColor,
                                            iconSize: 18,
                                            icon: const Icon(
                                                Icons.travel_explore),
                                            onPressed: _isLoading
                                                ? null // Desactiva el botón mientras está cargando
                                                : _launchUrlWithLoading, // Ejecuta la lógica con loading
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        color: subtitleTextColor,
                                        iconSize: 18,
                                        icon: Icon(isBookmarked
                                            ? Icons.bookmark
                                            : Icons.bookmark_border),
                                        onPressed: () {
                                          saveFacto(ref, isBookmarked);
                                        },
                                      ),
                                    ),
                                    CustomPopupMenuButton(
                                      width: width,
                                      handleClick: handleClick,
                                      subtitleTextColor: subtitleTextColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.35,
                height: height * 0.2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    linkImg,
                    width: width * 0.35,
                    height: height * 0.2,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMaintenanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Artículo en mantenimiento'),
          content: const Text('Vuelve luego.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveTitleFacto(String title) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> titles = prefs.getStringList('titles') ?? [];

    if (!titles.contains(title)) {
      titles.add(title);
      await prefs.setStringList('titles', titles);
    }

    List<String> titlesSaved = prefs.getStringList('titles') ?? [];
    // ignore: avoid_print
    print('LLAVES DE FACTOS DESPUES DE GUARDADAS: $titlesSaved');
  }

  void saveFacto(ref, isBookmarked) {
    ref.read(bookmarkedTitlesProvider.notifier).toggleBookmark(title);

    if (!isBookmarked) {
      showSavedFactoSnackBar(homeContext!);
    }
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

  void openWebviewUrlFacto(String linkFont, context, title, description) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (homeContext) => WebviewScreen(
                titleFacto: title,
                descriptionFacto: description,
                urlSourceFacto: linkFont,
              )),
    );
  }

  void shareUrl(descriptionFacto) {
    Share.share(
        '$descriptionFacto \n\nDescubre este y otros factos más usando la App Factos de Programación. Enlace a PlayStore aquí: url ');
  }

  void sendFactoToBlackList(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> blackList = prefs.getStringList('blackListFactos') ?? [];

    blackList.add(title);

    await prefs.setStringList('blackListFactos', blackList);

    Fluttertoast.showToast(
      msg: "No verás este Facto la próxima vez",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  void watchFactoDialog(BuildContext context, FactoModel facto) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permite cerrar el diálogo tocando fuera
      barrierColor: Colors.black.withOpacity(0.76),
      builder: (BuildContext context) {
        return Center(
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 20), // Margen horizontal
            decoration: BoxDecoration(
              color: Colors.black
                  .withOpacity(0.8), // Fondo semitransparente oscuro
              borderRadius: BorderRadius.circular(12), // Bordes redondeados
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize:
                      MainAxisSize.min, // Ajusta el tamaño al contenido
                  children: [
                    // Imagen de fondo con degradado
                    Stack(
                      children: [
                        // Imagen de fondo
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            facto.linkImg,
                            width: double.infinity, // Ancho completo
                            height: 200, // Altura fija
                            fit: BoxFit.cover, // Rellena el espacio
                          ),
                        ),
                        // Degradado oscuro sobre la imagen
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                        // Título sobre el degradado
                        Positioned(
                          bottom: 5,
                          left: 16,
                          right: 16,
                          child: Text(
                            facto.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Descripción con SingleChildScrollView
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Text(
                          facto.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Botón de cierre (icono X) en la esquina superior derecha
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white, // Color del icono
                      size: 24, // Tamaño del icono
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Cierra el diálogo
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
