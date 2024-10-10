import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/feature/home/presentation/widgets/facto_home_widget.dart';
import 'package:flutter/material.dart';

class preferencesListFactos extends StatelessWidget {
  const preferencesListFactos({
    super.key,
    required Future<List<FactoModel>>? facto,
  }) : _facto = facto;

  final Future<List<FactoModel>>? _facto;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FactoModel>>(
        future: _facto,
        builder:
            (BuildContext context, AsyncSnapshot<List<FactoModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var itemFacto = snapshot.data ?? <FactoModel>[];

            if (itemFacto.isEmpty) {
              return const Center(
                child: Text(
                  'No se encontró ningun facto',
                  style: TextStyle(fontFamily: 'Inter'),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: itemFacto.length,
                itemBuilder: (BuildContext context, int index) {
                  return FactoHomeWidget(
                    title: itemFacto[index].title,
                    description: itemFacto[index].description,
                    nameFont: itemFacto[index].nameFont,
                    linkFont: itemFacto[index].linkFont,
                    linkImg: itemFacto[index].linkImg,
                    homeContext: context,
                    facto: itemFacto[index],
                  );
                },
              );
            }
          }
        });
  }
}
