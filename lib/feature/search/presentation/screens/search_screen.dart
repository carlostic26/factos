import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:factos/feature/home/presentation/widgets/facto_home_widget.dart';
import 'package:factos/feature/search/presentation/provider/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchProvider);
    final searchFactos = ref.read(searchFactosProvider);

    return Scaffold(
        appBar: AppBar(
          title: TextField(
            decoration: const InputDecoration(
              hintText: 'Buscar...',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white54),
            ),
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold),
            onChanged: (value) {
              searchFactos(value);
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: Expanded(
          child: FutureBuilder<List<FactoModel>>(
            future: Future.value(searchState.searchResults),
            builder: (BuildContext context,
                AsyncSnapshot<List<FactoModel>> snapshot) {
              if (searchState.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (searchState.error != null) {
                return Center(child: Text('Error: ${searchState.error}'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                var itemFacto = snapshot.data ?? <FactoModel>[];

                if (itemFacto.isEmpty) {
                  return const Center(
                    child: Text(
                      'No se encontró ningún facto',
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
            },
          ),
        ));
  }
}
