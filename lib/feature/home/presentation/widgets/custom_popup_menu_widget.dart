import 'package:factos/feature/launch/presentation/screens/loading/loading_barrel.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final double width;
  final Function(String) handleClick;
  final Color subtitleTextColor;

  const CustomPopupMenuButton({
    super.key,
    required this.width,
    required this.handleClick,
    required this.subtitleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.05,
      height: 24, // Añadir una altura fija
      child: Center(
        // Centrar el PopupMenuButton verticalmente
        child: PopupMenuButton<String>(
          padding: EdgeInsets.zero, // Eliminar el padding por defecto
          icon: Icon(
            Icons.more_vert,
            color: subtitleTextColor,
            size: 20,
          ),
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return {
              'Revisar fuente',
              'Guardar',
              'Compartir mediante...',
              'Dejar de ver'
            }.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(
                  choice,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
