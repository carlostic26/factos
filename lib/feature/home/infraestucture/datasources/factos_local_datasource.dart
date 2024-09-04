import 'package:factos/core/error/failures.dart';
import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class FactoLocalDatasource {
  //repository
  //Future<List<FactoModel>> getCategoryFacto(String category);
  Future<List<FactoModel>> getAllFactoList();
  Future<FactoModel> getFacto(String description);
}

class SQLiteFactoLocalDatasourceImpl implements FactoLocalDatasource {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    try {
      String path = await getDatabasesPath();
      return openDatabase(
        join(path, 'facto_database_005.db'),
        onCreate: (db, version) async {
          const String sql = ''
              'CREATE TABLE factos ('
              ' id INTEGER PRIMARY KEY AUTOINCREMENT,'
              ' title TEXT,'
              ' preference TEXT,'
              ' category TEXT,'
              ' language TEXT,'
              ' description TEXT,'
              ' nameFont TEXT,'
              ' linkFont TEXT,'
              ' linkImg TEXT'
              ');';

          await db.execute(sql);

          // Historia: Años, inventos, personalidades en el tiempo

          // Fundadores: vida privada, estado actual, que le debe el mundo, edad del prime, dato de influencia

          // Curiosidades (lenguajes), datos graciosos, mitos, magnates, nuevas tecnologias, Logros de ciertos paises, datos curiosos,

          // Habilidades: orientado a las blandas

          // Tips: codigo eficiente, recomendaciones, ideas

          // Conceptos: prog en general, lenguajes, iot, ia, etc || No es... (no es lo mismo js que java, no es cierto que..), 10. Desarrollo we (front, back, frameworks) 11. Desarrollo mobile (frameworks, ios, android, nativos) 12. Desarrollo escritorio (Windows, linux, macOS)

          // Motivacional: curva de aprendizaje, experiencias de otros, cuanto tiempo le tomo a alguien lograr algo,

          // tengo un script sql, que debe insertar: un titulo, cateogoria, descripcion corta de 30 palabras como maximo, nombre de fuente de informacion, y un enlace a dicha fuente. Crea 5 INSERTS de datos reales y verdaderos, 2 para categoria "Historia", y 3 para "Curiosidades"

          /* '("Titulo...", "Historia", "En 1978 gracias a Fortran el hombre pudo llegar a luna.", "Harvard", "https://harvard.com"),' */

          const String addFacto = ''
              'INSERT INTO factos(title, preference, category, language, description, nameFont, linkFont, linkImg) VALUES '
              // Historia
              '("El primer programa de Ada Lovelace", "Historia", "Desarrollo de escritorio", "none", "En 1843, Ada Lovelace escribió el primer algoritmo destinado a ser procesado por una máquina.", "Wikipedia", "https://es.wikipedia.org/wiki/Ada_Lovelace", "https://blogger.googleusercontent.com/img/a/AVvXsEh7U5j7BBJUcDc9ZHcHYkTo46oc378epjwGnsBmYUObolEIQeU-DmlyUCmJqUCYhor9rxldRZez6oaUyqVxUZsMDTxGv4a1EzOEMoJrFUmRxwPYwhCstxjqYT2RV9n1nenqSW9vBoWVRkGpdlGetoJbsdyT9CXluvaccJiZspSNUBx50lA4EtVcn0Gb"),'
              //
              '("Nacimiento de FORTRAN", "Historia", "Desarrollo de escritorio", "none", "En 1957, IBM lanzó FORTRAN, el primer lenguaje de programación de alto nivel.", "IBM", "https://www.ibm.com/ibm/history/ibm100/us/en/icons/fortran/", "https://blogger.googleusercontent.com/img/a/AVvXsEjI52gomOrMi3JsI26CzB8mx0ZApmCm3PgmLcsV7LONoOPFu8OHRbgbm-Y1EPKySi8sCYgIdnevsrjGm4lOzuihzf7YKNI980vEZHUsz-G1YO0EiG6Vt_yGnHScJTHDvXS9LV83u6_uyIIYBC5vcnPaK2HIBqc_ooRcrjeqbrI85MlJKlzl_i-IofHk"),'
              //
              '("Nacimiento de la World Wide Web", "Historia", "Informatica", "none", "Tim Berners-Lee inventó la World Wide Web en 1989 en el CERN, revolucionando la comunicación global.", "CERN", "https://home.cern/science/computing/birth-web", "https://blogger.googleusercontent.com/img/a/AVvXsEi8FmggW5L5UIWRUW5IGgFMdTOFJuF7B8rVRfYdWou_mogZNcndsgHNSCr_IwnEkgz4m7RCkQbI6S4wdJxM-h3j_56Ap_372lKr2Ag07BrN2LYdMjetWlxPOplDan03_njqKlhOBlIU0U6KAJRXO-4sf5zEX8LqNKEwRkHWwVguXChI0keyTCciqW_W"),'
              //
              '("Creación del primer compilador", "Historia", "Desarrollo de software", "none", "Grace Hopper desarrolló el primer compilador A-0 en 1952, sentando las bases para los lenguajes de programación de alto nivel.", "Computer History Museum", "https://www.computerhistory.org/timeline/software-languages/", "https://blogger.googleusercontent.com/img/a/AVvXsEi43UlVVhhMQW2vX6gZGFVfAApkzIDMrXhY8Mf1M31cdTVFR-bzKFw6pxYWV5ZNJkXGsAyIMb3yRcSdZpH1lym0SbwVOCCo8zA8-l-CrR4MsY3cErPZIJZfmsX4CBoMvvQAym3KPXwatXOt5L4JV2HIioV8N0uAkx4gXo-qX9PHRJjzjwdsv5DX50RB"),'
              //
              '("El nacimiento de la programación", "Historia", "Desarrollo de software", "none", "En 1945, el ENIAC se convirtió en una de las primeras computadoras programables electrónicas de uso general.", "IBM", "https://www.ibm.com/history/eniac", "https://blogger.googleusercontent.com/img/a/AVvXsEiVt5fOefXi19phzuiWequeCPfU1dEgGJcYGDsEqpCDRewqIpvBzR8EwDrB456mIdeQSd1KwBkgTVh44Hwh4NP2jiZoHTRfRivzYKe8SC0SFCSMr7JshIbeteynzo49sBnXpZyJ26Th2f_cLxcg6b3hDtcrZoCp3YTe7BebhfA-x4_UQQvFsZZ1kBPH"),'
              //
              '("El primer lenguaje de programación", "Historia", "Lenguajes, Dessarrollo de software", "none", "En 1957, Fortran fue desarrollado por IBM como el primer lenguaje de programación de alto nivel.", "Computer History Museum", "https://www.computerhistory.org/blog/fortran-the-first-high-level-language/", "https://blogger.googleusercontent.com/img/a/AVvXsEh1-FhPxmZhPEJSPM_9o7vGnFmsyQtTi-F7q8zPGvfqIeF0BJp5hOYIl2-i8q-9bQxHhxqKknafbidlARZ5g_Mes2f2VtQRbqYE0-PRb_H128cB1L5oAUtL9fC4aFBRouaFS-woyA0OfW2Yg9I4Sik8hcxcFlvP7-KEVMn1uHpPXqixpeQ3lGLZWE2A"),'
              //

              // Conceptos

              // Tips

              // Motivacional

              // Fundadores

              // Curiosidades
              '("Lenguaje esotérico Brainfuck", "Curiosidades", "Lenguajes", "Brainfuck", "Brainfuck es un lenguaje de programación esotérico con solo ocho comandos, diseñado para ser lo más difícil de programar posible.", "Wikipedia", "https://es.wikipedia.org/wiki/Brainfuck", "https://blogger.googleusercontent.com/img/a/AVvXsEh9rEkocL3u7EBCcjw0HdHIjt2bWG6Uqz5Boi-J9LXzh7mTz5MpqQvc8zPsiEVyZjc1lsJhgjC3lGTlAM_RmSUOuwf6F4bdR4E1gju4gtZKYSYf92ApV5gUCL5anWwjCr_G8igrZDXUrnMwCdCsdWglUP9ctJ1RBrAJUC8CGB60pM1zpJSaezkcC_Zl"),'
              //
              '("Lenguaje Piet", "Curiosidades", "Lenguajes", "Piet", "Piet es un lenguaje de programación visual donde los programas son imágenes abstractas que ejecutan código en función del color y la disposición de las regiones.", "Esolangs", "https://esolangs.org/wiki/Piet", "https://blogger.googleusercontent.com/img/a/AVvXsEj9Vdv_T_e_2gdLU-5_HGXfeA2lr_Nw38P2JU-f4ahP_KKqCtp_-Kn335HUKmpDYOLnbWZyMiOXetzuhb4JwzM9IyVAr6CeL_6meVnvqTjkjTlIMnYqAeYGethvc8cOYP9ovWm6Xs9iUaurUU93DHQm1pPsZ0VFIbezSS6EkTV0Jy4RhnXrttLIVHWI"),'
              //
              '("Lenguaje Befunge", "Curiosidades", "Lenguajes", "Befunge", "Befunge es un lenguaje de programación donde el código se organiza en una cuadrícula bidimensional, permitiendo que el flujo de control se mueva en cualquier dirección.", "GeeksforGeeks", "https://www.geeksforgeeks.org/befunge-programming-language/", "https://blogger.googleusercontent.com/img/a/AVvXsEiqBuDbjZ2F9rCIqfv_sPY1I3FzdBNQxHpwY2pzMoZJ2vJ-hlTeeUyQ56uu6GjcbViSaXqNfBl8cz5_T3Ie1crhyLIpF0s9GuNZJnXxNyP03HUSZvcDL7lMUyve_1TZ-zi31Wzrr7DLsWY9g6GJJJ4joMwzsu_9gEwrzzgXMNL88r0Qzanui5hVRxJ6"),'
              //
              '("Lenguaje Malbolge", "Curiosidades", "Lenguajes", "Malbolge", "Malbolge es conocido como el lenguaje de programación más difícil de escribir, diseñado de manera que incluso escribir un simple Hello, World! sea extremadamente complejo.", "Esolangs", "https://esolangs.org/wiki/Malbolge", "https://blogger.googleusercontent.com/img/a/AVvXsEguOR7Y3HxHK47nkQfBoXhrnq_7dk2gtxX78d4dLUPt3yd-zYv7dAPw-bySKzTwdPVSj0jUocqX8cwYUr6_XmUxN-jYBk8KYKMdTYgFAazbKrp3ytBACfAXAaB6E7r7Kvb0ouULRl3ot0T_iWHEGsnkV0ewuNL_QSJw2DwHvaH6-9DW1eKINFYakeqR"),'
              //
              '("Lenguaje LOLCODE", "Curiosidades", "Lenguajes", "LOLCODE", "LOLCODE es un lenguaje de programación inspirado en los memes de gatos LOLCats, con una sintaxis que imita el estilo de escritura de estos memes.", "Wikipedia", "https://es.wikipedia.org/wiki/LOLCODE", "https://blogger.googleusercontent.com/img/a/AVvXsEiBxbYVUWCEYYkWHwTfAn0jcSsHvXdOtD1Oa9fLsBymR5DMJOB4DAYcYpoC5Ez-2PnTGWyq5db0Aov_B5sv3Q2JN1aZsoOCpKMLTJL2hhJ7F3PIwqI4BEoltvaCuRXAfhfnTKxq3aR81HzDN7vIm6nhuEy8utL4rcyki1PEDkrS3iqGtOWGncjvSmoN"),'
              //
              '("El origen del nombre de Python", "Curiosidades", "Lenguajes", "Python", "Python fue nombrado así por el grupo de comedia británico Monty Python.", "Python Software Foundation", "https://www.python.org/doc/essays/foreword/", "https://blogger.googleusercontent.com/img/a/AVvXsEjvJY_l7jfPkDugcr10ie10v8QqIlAZ0eSNvJDK-q8tYXlWD2rK3LXY6lCvS6GHt01iyZLW5pmLwK4dmXdFH_DvkWtBN14sWkr4jORVCfHvl5IqCd3vq4HuKi6Rbe4mSiSzTT08MKB0DSPFjQp-qN0awtHp7yXev_H2As5pMIeJ-D2YKQyfz_wkabmk"),'
              //
              '("El lenguaje Ada", "Curiosidades", "Lenguajes", "Ada", "Ada es un lenguaje de programación diseñado para sistemas críticos de seguridad, como los utilizados en la aviación y la defensa.", "AdaCore", "https://www.adacore.com/about-ada", "https://blogger.googleusercontent.com/img/a/AVvXsEh5dXG9_Op4kxKUxknOa9XvQ__hnDMvVBpxT8v0h1Hrjmx3cc-f72RdsSySoXNCMbE_kbUEViN0XYZtbZ_6tj2gYwfDwNeSJaESlRGX8935NtUeM3Ecv-ztHYw0TB-PMUmHYwqfiGJmpZjPL9D2BAmOpAxglck0GUANj8gzCjJ2AaZDWbR9MXOSfBGI"),'
              //
              '("El lenguaje Haskell", "Curiosidades", "Lenguajes", "Haskell", "Haskell es un lenguaje de programación puramente funcional, conocido por su fuerte sistema de tipos y su capacidad para manejar funciones de orden superior.", "Haskell", "https://www.haskell.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEiI4PXF8Xv3H68x7zZTUWO4YeKOfeGh6gIe2GDZ0S7c_DhF5lIybuS6EYbMokAMmT0eOOWFYl-Nc7njoEJ_af1X7YcLywkyz6AjdBEb66bouOQJOYM7ADU09RR1ZWJu-8sfSQM_yJNVctPcZbj6T6JawbC1ap9tQ0Ro777CPm6Acexpz6nsZsUmaPqW"),'
              //
              '("El lenguaje Erlang", "Curiosidades", "Lenguajes", "Erlang", "Erlang es un lenguaje de programación diseñado para sistemas concurrentes y distribuidos, utilizado principalmente en telecomunicaciones.", "Erlang", "https://www.erlang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEgyUBXtcCFotY69Zawq1p3fA2v89NKO3RUUQJqxFcsok3s8DjkUJzSXJ9ipTViLRPqTRmzslNCscTmPLUjTKjnf3EZxYunzk-x6gXWD6br341MQ9miecmxb2gGcbb3_q8Yme2p1ZEd84us9UzOb3--r38PxEIGqbFI13dE32SxUSDTqYpSWO2UqjgS1"),'
              //
              '("El lenguaje Forth", "Curiosidades", "Lenguajes", "Forth", "Forth es un lenguaje de programación utilizado en sistemas embebidos y de tiempo real, conocido por su eficiencia y flexibilidad.", "Forth", "https://www.forth.com/", "https://blogger.googleusercontent.com/img/a/AVvXsEgiSgBa9MIUn8OPX5BJ4DBKiXTuU8UOAnI86HVwcyD7WatbHgIyfYY8NiaDJqSfhzdujgId-YPJdRaU2R4hy-VsidRWGUmlfOhibtXGscoTKHshucL4Z8Bs7snLVfoxNdbRgFeE32ADp24NQz7M1BjaMK-VMZCdJQDV4xineRBvUg7OMq1rCcjmLfab"),'
              //
              '("El lenguaje Prolog", "Curiosidades", "Lenguajes", "Prolog", "Prolog es un lenguaje de programación lógico utilizado en inteligencia artificial y procesamiento de lenguaje natural.", "SWI-Prolog", "https://www.swi-prolog.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEi5Skk3INxgcb7Z1K6c7U_oD33LLt8fRJBweGFsB6A2ksrhn8Ctx89p0P-g9ooAPH6LJC9RS0Xc7AHygzZhwhYrm97QnyLnsDs3Uacls0OM8wjcQ7xipcIpOx-NN7AvPZUEuyKrU3AV2s1DKO0mNADDsz45aq6e0P-Pz307964oWRdiAHqIwi9q-93Z"),'
              //
              '("El lenguaje Lua", "Curiosidades", "Lenguajes", "Lua", "Lua es ampliamente utilizado en el desarrollo de videojuegos, especialmente en motores como Corona SDK y en la creación de mods para juegos como World of Warcraft.", "Lua", "https://www.lua.org/about.html", "https://blogger.googleusercontent.com/img/a/AVvXsEhvBeZw2AfhHhF-o6oG-WAt0yunYaQF7HsxDTBvyL_Gzd6i9fjk3u1eLZh-dmsel4l6XV2w8IHaGVr12kv7PV7LzGdx1kuPb53Uh2DS-WE_xLgNbYVVhBb5wtommgfP-JJ4bCt31p5nDdm3cDRmJpM4BrZIZgyQJcJMtfWYfqfEWJx6rPeenEZW2vXE"),'
              //
              '("El lenguaje Racket", "Curiosidades", "Lenguajes", "Racket", "Racket, derivado de Scheme, es un lenguaje multiparadigma utilizado principalmente en la educación de ciencias computacionales y para crear otros lenguajes de programación.", "Racket-lang", "https://racket-lang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEgzG08No1tFf2ZEGQ_Vj3WmlpzUxfLXhWxaprLwn0CctOdNBvgyWQCfLcIdsnn-0DB6BejmV4qE-TaG4wc2GqoKSlxj05oEko64Bt1CYNDH_Mk7-C9rNym7l3F4bsykp93joFxGNR1Fqs8FqV8Qu6gA0CSX_EcAXMIHZUM56ZL98dvdGOGMIPf4A_Qi"),'
              //
              '("El lenguaje Nim", "Curiosidades", "Lenguajes", "Nim", "Nim combina la eficiencia de C con la expresividad de Python y la elegancia de Lisp, siendo especialmente valorado en el desarrollo de sistemas.", "Nim-lang", "https://nim-lang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEhQibHdEL0IWvizTiNi4XUBAqm7ZmL3o9YgeRI6gPMR2hxU_0iOZtpe8GiAAkcnes4j7H2J38c9BhFc4XOXg3O0vk4_iwthJQECWdNhw58pYapGXzXA47aXa56lsWGJFb5GChr54LKSmRSvGhOyy0zFuI4fIST4Kvrp29SY41DDxdOlTUgpEVUJmW5e"),'
              //
              '("El lenguaje Haxe", "Curiosidades", "Lenguajes", "Haxe", "Haxe es un lenguaje de programación versátil que permite la compilación de código en varios lenguajes, incluyendo JavaScript, C++, y C#, siendo popular en el desarrollo de juegos y aplicaciones web.", "Haxe", "https://haxe.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEjv08pAehfmflgAyLv44RvBHoE7HQm_LNtN5P24Leg1Cngfto6rtkQxMBBHPQYSBUNf_e2DUNNwwPYX-PAk0c4Kl0H7xal5FQV82-vvDHXpGvXlFSAIrmDNBDVl9i6VqjsyG2RGUJ_X0I6l0jWeAaLbV335IrdLyRt33hSu-wUINROVHLn03chRuyZc"),'
              //
              '("El lenguaje Elixir", "Curiosidades", "Lenguajes", "Elixir", "Elixir es un lenguaje funcional, construido sobre la máquina virtual de Erlang, conocido por su capacidad para construir aplicaciones distribuidas y tolerantes a fallos.", "Elixir-lang", "https://elixir-lang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEiR1kOi0E6OaN8L_bCGcMozDW3I5RK-Yegdkzy71C58zr6OmTYGyKETQrGZ7_MMzEdm9YMz-7r_eUy73PrLTI_ti9OlgJyc0DqlRclpjzX5fEAdhko5YoI-SjFTZup3q81y47pwQylVyfEHbg-oj20Em3Ozqj1lElCtJeK59RwaCnjLqA1iNu53LEoz"),'
              //
              '("El lenguaje Whitespace", "Curiosidades", "Lenguajes", "Whitespace", "Whitespace es un lenguaje de programación que usa solo espacios, tabulaciones y saltos de línea.", "GeeksforGeeks", "https://www.geeksforgeeks.org/whitespace-programming-language/", "https://blogger.googleusercontent.com/img/a/AVvXsEi26ydQXOO0SnyUXdZDSMDHWEMotIaV6XAO3dhOv-HJBHDWePJ3hx1dsKDgW_TaSlS1zuuwqFYD8qiy-JddsKjr9CJNUOECudcl57yLpnTHtZJL3gvrusytt7bY0_07ZM9audO3U6uzsDDVLVV4aPM2hzBVDchNEX8Y7cpiSZu7MKM6OzzkI-BdR1tE"),'
              //
              '("Python y su nombre peculiar", "Curiosidades", "Lenguajes", "Python", "El lenguaje Python fue nombrado por su creador, Guido van Rossum, en honor al grupo cómico Monty Python.", "Python", "https://docs.python.org/3/faq/general.html#why-is-it-called-python", "https://blogger.googleusercontent.com/img/a/AVvXsEgk6jykLU5PFL7FqNOD144433Hj8KwwKs0-16o_tCPjUDd-HWPZQFXYOpopephsyBzmqWPMUppHD3TrGAEMPwkVkAJlV8QeDMNH0DhyZi6DHOMxirkfRD4lRNj0TZskpgZ7Rxl4_DAxgq2AQ3Yaj447Iveiy5heMZqVgYaNQUUEspnhiHlDONYkTdET"),'
              //
              '("Java y sus 3 mil millones de dispositivos", "Curiosidades", "Lenguajes", "Java", "Java se ejecuta en más de 3 mil millones de dispositivos, incluyendo smartphones, cajeros automáticos y electrodomésticos.", "Oracle", "https://www.oracle.com/java/technologies/", "https://blogger.googleusercontent.com/img/a/AVvXsEgXRAceKO3lMGRHFWb--JdLmFkTntkjYX1PGZ_w8vebT6xw0U9tA45yYYYxK0I6AunE_3dIIWcXywr7SWyDzDhCaOwkWgMp32D7y_xVhdsem2ro45uLKVxZDZnZsjtULejR-h14cPrW_90JkJvlXGAhSPEUiiqe8iwznazxyeRW_autSSQfa7dn5zMC"),'
              //
              '("El famoso Hello, World!", "Curiosidades", "Desarrollo de software", "C", "El mensaje Hello, World! fue popularizado por el libro de Brian Kernighan sobre C, mostrando un primer programa básico.", "Programming Historian", "https://programminghistorian.org/en/lessons/hello-world", "https://blogger.googleusercontent.com/img/a/AVvXsEjwen6811Ti-u4N9QVIMf04t9EgYo86fjajX1i2rg7YjmKsIUCsQdFPxw6AzmWkCmGFVUIKftLDIzGQ4DX7jQyDvyDIK7Nix3cBoZDrciHei_CWnBcjiY4bYZk19PwLPTW6pQTpTNlzI1N2dKu0cyrEh_EpPya1o15WGGMbPf_S69tAPa0RdOstJ-T9"),'
              //
              '("El origen accidental de JavaScript", "Curiosidades", "Lenguajes", "JavaScript", "JavaScript fue creado en solo 10 días por Brendan Eich en 1995, originalmente llamado Mocha.", "Mozilla", "https://developer.mozilla.org/en-US/docs/Web/JavaScript/About_JavaScript", "https://blogger.googleusercontent.com/img/a/AVvXsEg2nabFJ05Gtuuqj8ZMUgKuBMBMAZvVH13ViGBhRpj3frDrJ4_oORNZ3eCgIKu3Tzx-wX8pqn4UAI1u1uXBD794Xa8PHo8ji4OcnTSnmzoOLyh8s5sg6Ihr8FblQ-rw0gd-UkOhdxLl6xHic722ObFQ9FZR5RSJDlZitL-ApjfXqVXjkMAsNs3coR8y")';

          await db.execute(addFacto);
        },
        version: 1,
      );
    } catch (e) {
      throw Exception('Error al inicializar la base de datos: $e');
    }
  }

  @override
  Future<FactoModel> getCategoryFacto(String category) async {
    try {
      final db = await database;
      final maps = await db.query(
        'factos',
        where: 'category = ?',
        whereArgs: [category],
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
      debugPrint(e.toString());
      throw LocalFailure();
    }
  }

  Future<List<FactoModel>> getAllFactoList2() async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult =
        await db.rawQuery('SELECT * FROM factos');
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }

    return queryResult.map((e) => FactoModel.fromJson(e)).toList();
  }

  Future<List<FactoModel>> getCategory(cat) async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult = await db
        .rawQuery('SELECT * FROM factos WHERE category like ?', ['%$cat%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }

    return queryResult.map((e) => FactoModel.fromJson(e)).toList();
  }

  Future<List<FactoModel>> getPreference(pref) async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult = await db
        .rawQuery('SELECT * FROM factos WHERE category like ?', ['%$pref%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }

    return queryResult.map((e) => FactoModel.fromJson(e)).toList();
  }

  @override
  Future<FactoModel> getFacto(String description) {
    // TODO: implement getFacto
    throw UnimplementedError();
  }
}
