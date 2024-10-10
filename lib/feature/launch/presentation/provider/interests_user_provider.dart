import 'package:factos/feature/home/infraestucture/datasources/factos_local_datasource.dart';
import 'package:factos/feature/launch/presentation/screens/welcome/welcome_barrel.dart';

final factoLocalDatasourceProvider = Provider<FactoLocalDatasource>((ref) {
  return SQLiteFactoLocalDatasourceImpl();
});

final preferencesFactoProvider = FutureProvider<List<String>>((ref) async {
  final dataSource = ref.watch(factoLocalDatasourceProvider);
  return await dataSource.getAllPreferenceFacto();
});

final categoriesFactoProvider = FutureProvider<List<String>>((ref) async {
  final dataSource = ref.watch(factoLocalDatasourceProvider);
  return await dataSource.getAllCategoryFacto();
});
