import 'package:factos/feature/home/presentation/screens_home_barrel.dart';

class SearchedBarFactos extends StatelessWidget {
  const SearchedBarFactos({
    super.key,
    required this.searchState,
  });

  final SearchState searchState;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FactoModel>>(
      future: Future.value(searchState.searchResults),
      builder:
          (BuildContext context, AsyncSnapshot<List<FactoModel>> snapshot) {
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
                  homeContext: context,
                  facto: itemFacto[index],
                );
              },
            );
          }
        }
      },
    );
  }
}
