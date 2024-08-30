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

          // Historia: Años, inventos, personalidades en el tiempo

          // Fundadores: vida privada, estado actual, que le debe el mundo, edad del prime, dato de influence

          // Curiosidades (lenguajes), datos graciosos, magnates, nuevas tecnologias, Logros de ciertos paises, datos curiosos,

          // Habilidades: orientado a las blandas

          // Tips: codigo eficiente, recomendaciones, ideas

          // Conceptos: prog en general, lenguajes, iot, ia, etc || No es... (no es lo mismo js que java, no es cierto que..), 10. Desarrollo we (front, back, frameworks) 11. Desarrollo mobile (frameworks, ios, android, nativos) 12. Desarrollo escritorio (Windows, linux, macOS)

          // Motivacional: curva de aprendizaje, experiencias de otros, cuanto tiempo le tomo a alguien lograr algo,

          // tengo un script sql, que debe insertar: un titulo, cateogoria, descripcion corta de 30 palabras como maximo, nombre de fuente de informacion, y un enlace a dicha fuente. Crea 5 INSERTS de datos reales y verdaderos, 2 para categoria "Historia", y 3 para "Curiosidades"

          /* '("Titulo...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com"),' */

          const String addFacto = ''
              'INSERT INTO factos(title, category, description, nameFont, linkFont) VALUES '
              // Historia
              '("El primer programa de Ada Lovelace", "Historia", "En 1843, Ada Lovelace escribió el primer algoritmo destinado a ser procesado por una máquina.", "Wikipedia", "https://es.wikipedia.org/wiki/Ada_Lovelace"),'
              //
              '("Nacimiento de FORTRAN", "Historia", "En 1957, IBM lanzó FORTRAN, el primer lenguaje de programación de alto nivel.", "IBM", "https://www.ibm.com/ibm/history/ibm100/us/en/icons/fortran/"),'
              '("Nacimiento de la World Wide Web", "Historia", "Tim Berners-Lee inventó la World Wide Web en 1989 en el CERN, revolucionando la comunicación global.", "CERN", "https://home.cern/science/computing/birth-web"),'
              //
              '("Creación del primer compilador", "Historia", "Grace Hopper desarrolló el primer compilador A-0 en 1952, sentando las bases para los lenguajes de programación de alto nivel.", "Computer History Museum", "https://www.computerhistory.org/timeline/software-languages/"),'
              //
              '("El nacimiento de la programación", "Historia", "En 1945, el ENIAC se convirtió en una de las primeras computadoras programables electrónicas de uso general.", "IBM", "https://www.ibm.com/history/eniac"),'
              //
              '("El primer lenguaje de programación", "Historia", "En 1957, Fortran fue desarrollado por IBM como el primer lenguaje de programación de alto nivel.", "Computer History Museum", "https://www.computerhistory.org/blog/fortran-the-first-high-level-language/"),'
              //

              // Conceptos

              // Tips

              // Motivacional

              // Curiosidades

              // Fundadores

              '("El origen de Python", "Curiosidades", "Python fue nombrado así por el grupo de comedia británico Monty Python.", "Python Software Foundation", "https://www.python.org/doc/essays/foreword/"),'
              //
              '("El lenguaje Whitespace", "Curiosidades", "Whitespace es un lenguaje de programación que usa solo espacios, tabulaciones y saltos de línea.", "GeeksforGeeks", "https://www.geeksforgeeks.org/whitespace-programming-language/"),'
              //
              '("Python y su nombre peculiar", "Curiosidades", "El lenguaje Python fue nombrado por su creador, Guido van Rossum, en honor al grupo cómico Monty Python.", "Python.org", "https://docs.python.org/3/faq/general.html#why-is-it-called-python"),'
              //
              '("Java y sus 3 mil millones de dispositivos", "Curiosidades", "Java se ejecuta en más de 3 mil millones de dispositivos, incluyendo smartphones, cajeros automáticos y electrodomésticos.", "Oracle", "https://www.oracle.com/java/technologies/"),'
              //
              '("El famoso Hello, World!", "Curiosidades", "El mensaje Hello, World! fue popularizado por el libro de Brian Kernighan sobre C, mostrando un primer programa básico.", "Programming Historian", "https://programminghistorian.org/en/lessons/hello-world"),'
              //
              '("El origen accidental de JavaScript", "Curiosidades", "JavaScript fue creado en solo 10 días por Brendan Eich en 1995, originalmente llamado Mocha.", "Mozilla", "https://developer.mozilla.org/en-US/docs/Web/JavaScript/About_JavaScript")';

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
