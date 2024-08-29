import 'package:factos/core/error/failures.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class FactoLocalDatasource {
  //repository
  Future<List<FactoModel>> getAllFactoList();
  Future<FactoModel> getFacto(String description);
}

class SQLiteFactoLocalDatasourceImpl implements FactoLocalDatasource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    try {
      String path = await getDatabasesPath();
      return openDatabase(
        join(path, 'facto_database_001.db'),
        onCreate: (db, version) async {
          const String sql = ''
              'CREATE TABLE factos ('
              ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' title TEXT,'
              ' category TEXT,'
              ' description TEXT,'
              ' nameFont TEXT,'
              ' linkFont TEXT'
              ');';

          await db.execute(sql);

          /* '("Un dia como hoy...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com"),' */

          const String addFacto = ''
              'INSERT INTO factos(title, category, description, nameFont, linkFont) VALUES '
              //
              '("Un dia como hoy...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com"),'
              //
              '("Un dia como hoy...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com"),'
              //
              '("Un dia como hoy...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com"),'
              //
              '("Un dia como hoy...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com")';

          await db.execute(addFacto);
        },
        version: 1,
      );
    } catch (e) {
      throw Exception('Error al inicializar la base de datos: $e');
    }
  }

  @override
  Future<FactoModel> getFacto(String description) async {
    try {
      final db = await database;
      final maps = await db.query(
        'factos',
        where: 'description = ?',
        whereArgs: [description],
      );

      if (maps.isNotEmpty) {
        return FactoModel.fromJson(maps.first);
      } else {
        throw Exception('ID no encontrado');
      }
    } catch (e) {
      //throw Exception('Error al obtener el Todo: $e');
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  @override
  Future<List<FactoModel>> getAllFactoList() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('factos');

      return List.generate(maps.length, (i) {
        return FactoModel.fromJson(maps[i]);
      });
    } catch (e) {
      //throw Exception('Error al obtener la lista de Todos: $e');
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }
}
