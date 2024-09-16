import 'package:factos/core/config/styles/constants/theme_data.dart';
import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/feature/home/presentation/widgets/facto_home_widget.dart';
import 'package:flutter/material.dart';

class SavedFactos extends StatefulWidget {
  const SavedFactos({super.key});

  @override
  State<SavedFactos> createState() => _SavedFactosState();
}

class _SavedFactosState extends State<SavedFactos> {
  late SQLiteFactoLocalDatasourceImpl handler;
  Future<List<FactoModel>>? _facto;
  bool isFactos = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSavedFactosFromSharedPreferences();
  }

  Future<List<FactoModel>> conectionSavedFactos() async {
    return await handler.getFactosListFromSharedPreferences();
  }

  Future<void> getSavedFactosFromSharedPreferences() async {
    handler = SQLiteFactoLocalDatasourceImpl();

    handler.initDb().whenComplete(() async {
      List<FactoModel> listSavedFactos = await conectionSavedFactos();

      setState(() {
        _facto = Future.value(listSavedFactos);

        if (_facto != null) {
          isFactos = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundGlobalColor,
      appBar: AppBar(
        title: const Text(
          'Guardados',
          style: TextStyle(
              fontFamily: 'Inter', fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Expanded(
        child: FutureBuilder<List<FactoModel>>(
            future: _facto,
            builder: (BuildContext context,
                AsyncSnapshot<List<FactoModel>> snapshot) {
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
                      'Aun no tienes factos guardados',
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
                      );
                    },
                  );
                }
              }
            }),
      ),
      bottomNavigationBar: const SizedBox(height: 70, child: Placeholder()),
    );
  }
}
