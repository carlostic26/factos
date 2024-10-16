import 'package:factos/feature/home/infraestucture/models/factos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class FactoLocalDatasource {
  //repository
  Future<List<FactoModel>> getAllFactoList();
  Future<List<FactoModel>> getListPreferenceFacto(category);
  Future<int> countFactos();
  Future<List<String>> getAllPreferenceFacto();
  Future<List<String>> getAllCategoryFacto();
}

class SQLiteFactoLocalDatasourceImpl implements FactoLocalDatasource {
  Database? _database;
  int dbVersion = 3;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    try {
      String path = await getDatabasesPath();
      return openDatabase(
        join(path, 'facto_database_$dbVersion.db'),
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

          // tengo un script sql, que debe insertar: un titulo, categoria, descripcion corta de 30 palabras como maximo, nombre de fuente de informacion, y un enlace a dicha fuente. Crea 5 INSERTS de datos reales y verdaderos, 2 para categoria "Historia", y 3 para "Curiosidades"

          /* '("Titulo...", "preference", "category", "none", "descrip", "namefont", "linkfont", "linkImg"),' */

//prefenrecia: Historia, Fundadores, Tips, Conceptos, Motivacional,
//categoria: Desarrollo de esritorio, Informatica, Programación, Tecnologias,

          const String addFacto = ''
              'INSERT INTO factos(title, preference, category, language, description, nameFont, linkFont, linkImg) VALUES '
              // Historia
              '("La madre de la programación", "Historia", "Desarrollo de software", "none", "Ada Lovelace fue tan pero tan crack que escribió un algoritmo tan adelantado a su tiempo que ni siquiera existía una máquina para ejecutarlo.", "Wikipedia", "https://es.wikipedia.org/wiki/Ada_Lovelace", "https://blogger.googleusercontent.com/img/a/AVvXsEh7U5j7BBJUcDc9ZHcHYkTo46oc378epjwGnsBmYUObolEIQeU-DmlyUCmJqUCYhor9rxldRZez6oaUyqVxUZsMDTxGv4a1EzOEMoJrFUmRxwPYwhCstxjqYT2RV9n1nenqSW9vBoWVRkGpdlGetoJbsdyT9CXluvaccJiZspSNUBx50lA4EtVcn0Gb"),'
              //
              '("El abuelo de los lenguajes", "Historia", "Desarrollo de software", "Fortran", "Esto te va a volar la cabeza: en 1957, los cerebritos de IBM crearon FORTRAN, el primer lenguaje de programación de alto nivel. ¡Imagínate programar antes de esto! Era como escribir en binario, un auténtico dolor de cabeza.", "Fortran Lang", "https://fortran-lang.org/es/index", "https://blogger.googleusercontent.com/img/a/AVvXsEjI52gomOrMi3JsI26CzB8mx0ZApmCm3PgmLcsV7LONoOPFu8OHRbgbm-Y1EPKySi8sCYgIdnevsrjGm4lOzuihzf7YKNI980vEZHUsz-G1YO0EiG6Vt_yGnHScJTHDvXS9LV83u6_uyIIYBC5vcnPaK2HIBqc_ooRcrjeqbrI85MlJKlzl_i-IofHk"),'
              //
              '("El Big Bang del internet", "Historia", "Informatica", "none", "No lo sabias, pero en 1989 un tipo llamado Tim Berners-Lee creó la World Wide Web en el CERN. Sí, ese lugar donde juegan con partículas. Este enfermo de la informática revolucionó la comunicación global y básicamente creó el mundo moderno. ¡Gracias, Tim!", "CERN", "https://home.cern/science/computing/birth-web", "https://blogger.googleusercontent.com/img/a/AVvXsEi8FmggW5L5UIWRUW5IGgFMdTOFJuF7B8rVRfYdWou_mogZNcndsgHNSCr_IwnEkgz4m7RCkQbI6S4wdJxM-h3j_56Ap_372lKr2Ag07BrN2LYdMjetWlxPOplDan03_njqKlhOBlIU0U6KAJRXO-4sf5zEX8LqNKEwRkHWwVguXChI0keyTCciqW_W"),'
              //
              '("La traductora de máquinas", "Historia", "Desarrollo de software", "none", "La increíble Grace Hopper desarrolló el primer compilador A-0. ¿Que qué es eso? Pues nada, solo la base de todos los lenguajes de programación de alto nivel. Sin ella, estaríamos programando como cavernícolas.", "UGR", "https://www.ugr.es/~eaznar/hopper.htm", "https://blogger.googleusercontent.com/img/a/AVvXsEi43UlVVhhMQW2vX6gZGFVfAApkzIDMrXhY8Mf1M31cdTVFR-bzKFw6pxYWV5ZNJkXGsAyIMb3yRcSdZpH1lym0SbwVOCCo8zA8-l-CrR4MsY3cErPZIJZfmsX4CBoMvvQAym3KPXwatXOt5L4JV2HIioV8N0uAkx4gXo-qX9PHRJjzjwdsv5DX50RB"),'
              //
              '("El dinosaurio de las computadoras", "Historia", "Desarrollo de software", "none", "Ojo: en 1945, nació ENIAC, una de las primeras bestias programables electrónicas. Esta mole ocupaba una habitación entera y pesaba 27 toneladas. ¡Y tú quejándote de tu portátil de 2 kilos!", "UPV", "https://museo.inf.upv.es/eniac-2/", "https://blogger.googleusercontent.com/img/a/AVvXsEiVt5fOefXi19phzuiWequeCPfU1dEgGJcYGDsEqpCDRewqIpvBzR8EwDrB456mIdeQSd1KwBkgTVh44Hwh4NP2jiZoHTRfRivzYKe8SC0SFCSMr7JshIbeteynzo49sBnXpZyJ26Th2f_cLxcg6b3hDtcrZoCp3YTe7BebhfA-x4_UQQvFsZZ1kBPH"),'
              //
              '("El lenguaje que cambió el juego", "Historia", "Desarrollo de software", "Fortran", "Fortran es el papá. Asi de simple. En 1957 los genios de IBM crearon Fortran, el primer lenguaje de programación de alto nivel. Antes de esto, programar era como hablar con la máquina en su idioma. Fortran fue como inventar el esperanto para computadoras.", "DataScientest", "https://datascientest.com/es/fortran-todo-sobre-el-primer-lenguaje-de-programacion#:~:text=En%201957%2C%20tras%20tres%20a%C3%B1os,programas%20con%20gran%20intensidad%20num%C3%A9rica.", "https://blogger.googleusercontent.com/img/a/AVvXsEh1-FhPxmZhPEJSPM_9o7vGnFmsyQtTi-F7q8zPGvfqIeF0BJp5hOYIl2-i8q-9bQxHhxqKknafbidlARZ5g_Mes2f2VtQRbqYE0-PRb_H128cB1L5oAUtL9fC4aFBRouaFS-woyA0OfW2Yg9I4Sik8hcxcFlvP7-KEVMn1uHpPXqixpeQ3lGLZWE2A"),'
              //

              // Pioneros
              '("El cerebro detrás de las máquinas", "Pioneros", "Informatica", "none", "Un matemático británico con cerebro de otro planeta, es considerado el padre de la computación e inteligencia artificial. Este crack inventó la Prueba de Turing, básicamente un examen para ver si las máquinas pueden pensar. ¡Imagínate, le puso exámenes a las computadoras!", "Universidad de Cambridge", "https://www.cam.ac.uk/research/news/alan-turing-at-cambridge", "https://blogger.googleusercontent.com/img/a/AVvXsEgs6AXevJCxdsaPh53GJKVRYKKP52T_uH_BdKSBV9_xMLfR84_4PGWiIgsoYQgTmH2Pe3OEXuNTztDGgz9xeW7hU2up6oHfw_coNB8PfmWLSYbFz_TOTUpT8OK1mvy5GTuU04vEtzPaGw4vh9_OniUgBO7sVYFAdK3n11eZ4yBP81ZvCTBflwXeLzqI"),'
//
              '("El man que digitalizó el mundo", "Pioneros", "Informatica", "none", "Esto te va a volar la cabeza: Claude Shannon, un matemático e ingeniero estadounidense, es el responsable de que puedas leer esto en tu pantalla. Este genio inventó la teoría de la información y aplicó el álgebra booleana a los circuitos eléctricos. Básicamente, convirtió el mundo en unos y ceros. ¡Un auténtico mago digital!", "Eset", "https://www.eset.com/latam/blog/cultura-y-seguridad-digital/quien-fue-claude-shannon-y-como-revoluciono-la-era-digital/", "https://blogger.googleusercontent.com/img/a/AVvXsEixAmvQecKD2txt_12AhREvKq8SA7xAh8QKxpW106p7IxqOynNKfxRW7u5RQfzTtyNtnQercPvoWHVOLnJyL82nxkjEd4H-rhB_RHt9Q6uzt-0CDjl7Ze-g7ETc6oSaMCdoup798W7k3WvNtY30KJPBZcJtmiZPz5ty4Q2CI77xeawhpHA7Kg5m6vHT"),'
              //
              '("La primera programadora", "Pioneros", "Tecnologías", "none", "Ada Lovelace fue la primera programadora de la historia, ¡en 1843! Creó el primer algoritmo para ser procesado por una máquina. Ada, eres una leyenda. Esta visionaria vio el potencial de las computadoras más allá de los números.", "WomenInTech", "https://womenintech.com/ada-lovelace", "https://blogger.googleusercontent.com/img/a/AVvXsEiilfyvjZgbgtD9u1hIPS5Ro0fco3l28uMEgK0f4szntjRWVMumpp7QUwYTcVTLiroZPoOhU0L80rxgD-xINs4wOYtQLO15cwxerWNTcqNXliJIQ8wnDD3Hwl7wtZa1gg4Xzc1T7q_C69vccwy3IICDmWDXwlxRhAYxEraV_UDwITHx-HZttZoe1oiz"),'
              //
              '("El padre del pingüino", "Pioneros", "Tecnologías", "none", "Linus Torvalds cambió el juego. Creó Linux en su habitación a los 21 años. Hoy, su sistema operativo domina servidores y supercomputadoras. ¡Poder al open source! Este finlandés demostró que la colaboración global puede crear maravillas tecnológicas.", "LinuxFoundation", "https://linuxfoundation.org/linus", "https://blogger.googleusercontent.com/img/a/AVvXsEhdb-WqMSxQ4XMxOJmDgaQMv498z-q_izWbBs_CQbT2eSFWrZB-w5-8fusJIH2pPiGfjuyVxd7V4j7l1eHE-biCXu7o6CzIiiqoNb0qkUmjTkoSlMQovWiRlp2wwMPPNmcF2EuMl0NP0HBUpzeFSDBAu-iEWNKXh2PpRwLQxMQItwk6pQkWzhL7jl1u"),'
              //
              '("La reina de los compiladores", "Pioneros", "Tecnologías", "none", "Esta mujer es la reina de los compiladores. No hay otra forma de describirla. Grace Hopper, siendo naval, creó el primer compilador en 1952, sentando las bases de los lenguajes de programación modernos. Además, popularizó el término bug en programación. ¡Genio y figura!", "CIS", "https://blog.cis.upenn.edu/grace-murray-hopper-pioneering-the-digital-frontier/", "https://blogger.googleusercontent.com/img/a/AVvXsEi6ft3IM1B0q_GmieT_3i93aNEDrmYdSjO7rtfQvDC-r-jMoYBSloEQUvfHQRqjXuUNy3NkfV7tLsuDaNnW-T1xVPodbtE7N_-SFKxK6MC0oOvmhn8pzkehZW5284vy2a9lEGcXO6vW-97cR-tODVZ-NTJInasw8z_levWYH9OlXfTBgIuQq1OKZHpx=w945-h600-p-k-no-nu"),'
              //
              '("El tejedor de la Web", "Pioneros", "Desarrollo web", "none", "Este grande es una especie de Spiderman. Tim Berners-Lee inventó la World Wide Web en 1989. Sin él, no estarías leyendo esto. La hizo libre y abierta para todos. Su visión conectó al mundo y revolucionó la comunicación global.", "CIS", "https://www.cisinformatica.cat/es/tim-berners-lee-que-invento/", "https://blogger.googleusercontent.com/img/a/AVvXsEheMqeIWHi2oCS3K3OFXpYZf78b0t5ThTdIxZgwCQjv7bJB3VQRuJEzUIO5AcvZeg1PnCNO9ifjcMU9tkxS10GmWxyU68WMroUHgCFz5lhvM2HoinfRnowonbeotbQ79rmxiEzXPhokYc_CPRs1m-v5Ytx1rK3zOT2n6ssuuDvsFh2bdiqxn-yEdR4z"),'
              //
              '("Este lenguaje se creó en 10 dias", "Pioneros", "Desarrollo web", "none", "¿10 días para crear un lenguaje? Brendan Eich lo hizo con JavaScript en 1995. Hoy es el lenguaje más usado en desarrollo web. ¡Velocidad nivel: Eich! Su creación transformó la web de estática a dinámica e interactiva.", "W3School", "https://www.w3schools.com/js/js_history.asp", "https://blogger.googleusercontent.com/img/a/AVvXsEiIFdhpw_CZOPRw7JfY-vVZJN3KSyD01kGDGwdC_NAL8nOJdSCoC8WXigxGw9ziHOkjTdn2blvdWdKKbnfDYqOuCghhrP0I4XlynNM1vng6Fyw55GP_QJfJFQyYD3XxC7hG8i75rtwf_SRZkPrnpgqyedI020hkZeoxsfYeMsqhB6zxYpApPAwwsPx_"),'
              //
              '("El rockstar de los videojuegos", "Pioneros", "Desarrollo de videojuegos", "none", "John Carmack, un verdadero pionero, revolucionó los videojuegos 3D. Creó motores para Doom y Quake, sentando las bases de los FPS modernos. Sus innovaciones en gráficos 3D cambiaron para siempre la industria del gaming.", "TokioSchool", "https://www.tokioschool.com/noticias/desarrolladores-videojuegos-john-carmack/", "https://blogger.googleusercontent.com/img/a/AVvXsEjVEGxPGiVGLQqz2hHptzAUjKon_0rQEq491ponZMTGUfmReZi6V4N3x6gO8ozYQ4Phm0vlGXqD7uRcm-sv7Iz4ofgLIW8Nawv9WyE8YPta09VcMoaY_ootXDmTgBJQMZTb-LemEu3eq7YDdQysUCANKsvxsib_1LDFzBLCyc-mnRoiOd3Mmq1EV0w5"),'
              //
              '("Código lunar", "Pioneros", "Tecnologías", "none", "Margaret Hamilton lideró el equipo que escribió el software para el Apollo 11. Su código llevó al hombre a la luna. Margaret, ¡eres de otro planeta! Esta pionera acuñó el término ingeniería de software y revolucionó la programación.", "NASA", "https://science.nasa.gov/people/margaret-hamilton/", "https://blogger.googleusercontent.com/img/a/AVvXsEgIF8gILw4k3Qc3HpINZWM7yoFnsnQiy8s6q-hIwtj6g8WJOqHVXqqsoc6CwKeUDP-BBXtlXwAU5hXl76xhFj1rmbrmueA-BXO2gJYrMvswBpPpIcQ1nh6pIIuBYpN1icOc3j4ajaiJei_i5bot2cikcOvtHIrbVV2RIDdl-SV_n_ZgCbHENmLnSZqK"),'
              //
              '("El visionario de la nube", "Pioneros", "Tecnologías", "none", "Satya Nadella transformó Microsoft. Llevó la empresa a la nube, convirtiéndola en líder en IA y servicios cloud. ¡Un jefe que sabe hacia dónde sopla el viento! Su liderazgo cambió la cultura de Microsoft y revitalizó la compañía.", "HiperTextual", "https://hipertextual.com/2021/06/satya-nadella-transformacion-microsoft", "https://blogger.googleusercontent.com/img/a/AVvXsEgSkxY7I3ZKB1jYB0QcOUyJlJzCqTHILIQWf6rJ0fUasM7myj2J9E8X_B_gLpxOoVwNFwPlBXPsl1mRRW8DD6ne5K8o3IasqsJ53kT978GjoVYJQ6430lFiix95CSNW1LJrFpvmviSQTIL1O_RniPqwbuBe1vCLs5vo7RLASReTEe5nK-cqOZzirIGN"),'
              //
              '("El regalo navideño que conquistó el mundo", "Pioneros", "Tecnologías", "none", "Guido van Rossum creó Python como hobby navideño. Hoy es el lenguaje más popular en IA y data science. ¡Guido, has cambiado el juego! Su filosofía de diseño, enfocada en la legibilidad, revolucionó la forma de programar.", "GVanRossum", "https://gvanrossum.github.io//", "https://blogger.googleusercontent.com/img/a/AVvXsEjxd1Ju8g6Gcx8v9oTtU4kATm49kdjavtPfK35eT4FM74-L_GitLliNCrjc-vn3KIsOqlQbua7TgDy58gQWKLo9NVbpqJPLqInL3BdN8congojkBX9wc2b_aMW8YQPtGhhWikftvN_U45jf4U5TfNFhW3gjjKM1rsTnXtzYjW9ahqC3bCwVKxKGMfKH"),'
              //
              '("El mago de la manzana", "Pioneros", "Tecnologías", "none", "Steve Wozniak, el genio detrás del Apple I y II. Este ingeniero hizo realidad la computadora personal. Sin él, quizás no tendrías un smartphone. ¡Gracias, Woz! Su visión de llevar la tecnología a los hogares cambió el mundo para siempre.", "Wikipedia", "https://es.wikipedia.org/wiki/Steve_Wozniak", "https://blogger.googleusercontent.com/img/a/AVvXsEiGsVwBc3FAdi0QQmL4h5y3Xqy1GNMaa3BmXgsg-0CKhciRjXC6WbX8ih_lv1sebeKxWfrqhbeuk3qScos4COATKYf_06wakLtmFU_WEm9C-Re_Z1vDLBNWiZk96T0yfF43xxOp7SNf4CIHD9hSGe0vAUv2OHq2-Yv7viEPzXGeZep6Oa-lbAFREA6W"),'

              // Motivacional
              '("Motivación a prueba de bugs", "Motivacional", "Habilidades de TI", "none", "El éxito en programación no es para genios, es para tercos. Si te estancas, respira hondo y sigue dandole. Cada error te acerca a la solución. Si no le metes duro entonces andate a estudiar ingenieria industrial. La persistencia es tu superpoder en este mundo de bits y bytes.", "Quora", "https://es.quora.com/Qu%C3%A9-les-motiva-a-programar", "https://blogger.googleusercontent.com/img/a/AVvXsEjwwHwzIrg--WryugwPaZTynMRgNmy_mUDlQ3yd_hHf2KmcOEcrObMToyMkTFDR-nAAQ5BUsRYPUqTTdLXU4UQRjXrhrlqP1rbnGphyUmhOONWD9MXJINxa8Zo6CUVaKorSClkdAUty8wa0I0qptViUYsDchkC-TUJ1NP78Zci-P8wbXA20XbEzVJsB"),'
              //
              '("El código no tiene límites", "Motivacional", "Desarrollo web", "none", "Olvídate del síndrome del impostor. Cada línea de código que escribes te hace más pro. Atrévete a tomar proyectos que te asusten. Tu potencial es infinito, así que a programar sin miedo.", "Asana", "https://asana.com/es/resources/impostor-syndrome", "https://blogger.googleusercontent.com/img/a/AVvXsEiBTlSahGPTvOLmZ0J3OS0Mp2Z-1Mw7wZeZ5u1L9KTx3FoDdX06-7nSkgeIuQJEYBo79zkMaXs4OmNk12b9uJZCoqVZptyxbMd3JKklWYaUwmzPy2wcZmna5EXxJA5BVKEXiciO1L-C2mJeAo4YyRPS7UFO24sBfeqwOBvSShhc6J4j6dngZ5DEZEE_"),'
              //
              '("Apps que cambian el mundo", "Motivacional", "Desarrollo mobile", "none", "Tú puedes crearlas. La clave no es el talento, es la constancia. Dedica tiempo cada día, y verás cómo tu código se vuelve imparable. Cada línea de código es un paso hacia la revolución mobile.", "MobileDevLife", "https://theobjective.com/further/tecnologia/2016-08-29/apps-para-los-que-quieren-cambiar-el-mundo/", "https://blogger.googleusercontent.com/img/a/AVvXsEgmwlcfFHG4oj3yudr6cYLKgsyB0ipBqwjHAs51KMCBK02Kk4yLWNwhYszfU1GBDPxcJYmwLVV2M-UsH7suaV98wweQPB7IbZi-3vF7bUJsia6hyZjCwEbicb8yb5bPwSxn_VTDS-sMzUfTPCQZHYF1sog3P9Dn2uRN_PghBlPw2gDULTqyjWRYY9Vk"),'
              //
              '("IA: Tu aliada, no tu reemplazo", "Motivacional", "IA", "none", "La IA no reemplazará a los programadores creativos. Sé el que inventa, no el que copia. Experimenta, combina tecnologías, crea algo único. El futuro es de los valientes. Tu creatividad es el ingrediente secreto que ninguna IA puede replicar.", "Gaceta", "https://www.gaceta.unam.mx/la-ia-no-sustituira-los-procesos-creativos-y-de-innovacion/#:~:text=La%20creatividad%20y%20la,y%20necesidades%20de%20la%20sociedad.", "https://blogger.googleusercontent.com/img/a/AVvXsEjDkrPJzG2lnWRvlMzmM3jHtC0lBYUXg8t8l_23qj7UOsNVoUCX6GWhwv2Y6AvQpXlXBTP6-hOtKEUYi0cWlREzqKtM07BOogI8yKUm9_QzW05-I8Je7gXrb2nsLOrDdLiK-5e4F0aut5zkVQEGjuJ4FOpX6hPyerjVBsfqUGxLy8vO38qDwq5mD0a4"),'
              //
              '("Unidos por el código", "Motivacional", "Habilidades de TI", "none", "Olvida el lobo solitario. En tech, el trabajo en equipo es poder. Aprende a colaborar, comparte conocimientos, y verás cómo tus proyectos se disparan. ¡Unidos somos imparables! El mejor código es el que se escribe en equipo.", "Hackaboss", "https://www.hackaboss.com/blog/liderazgo-trabajo-equipo-sector-tic", "https://blogger.googleusercontent.com/img/a/AVvXsEiz6Dyp4HSXpxgDFdCJe7aMYlFEdlpmVA5i9WVsw-8LyiuLEl0OV5kk2p_3rAXnHdpU_woSY0nxZkJDvogZOsygbGvHt9HzJ1B-ewTZzSmDbXdf6cIJIBjSzUNrLlMH8gtk4H1KrRHRUMDIyAGCa2gjZrCjkTbpB65zAKGRtZQS3FFOSZUKhIMY_OEH"),'

//

              // Conceptos

              '("¿Que rayos son los microservicios?", "Conceptos", "Desarrollo web", "none", "Resulta que existe una arquitectura tan flexible que Netflix y Amazon la usan para manejar millones de usuarios. En lugar de una aplicación gigante, dividen todo en pequeños servicios independientes. Los microservicios es una arquitectura que lo cambia todo.", "AWS", "https://aws.amazon.com/microservices/", "https://blogger.googleusercontent.com/img/a/AVvXsEjOA7oIiSNfhBbex8Ytm4UZBGxgiSSIvf2DFbpdPBXU5AS-eoUkDhgcBPYwC-O6PSimflyKU73SwlrPNSvjKVBzrGoShnPoAT0tvDmgP4iQ5YV-OY1B2PpIGHQ5ylAVhfQ4HBhxmSeirLTGgqVtGivhXQwhM8L-BAhBmWZ2Szf1Zbyg6HMvIxTTixPY"),'
              //
              '("¿Clean code?", "Conceptos", "Desarrollo web", "none", "Este concepto es tan heavy que cambió la forma de programar para siempre. Imagina código tan limpio y claro que hasta tu abuela podría entenderlo. El tío Bob Martin revolutionó el desarrollo con esta biblia.", "Clean Code Book", "https://www.oreilly.com/library/view/clean-code-a/9780136083238/", "https://blogger.googleusercontent.com/img/a/AVvXsEgbsEAosRkBtZZwxIDy883BO8VFdvNWfUAwwWZZY_lOi1aBP_ydMpBOxdYGh4ZmUlkAqiJ1ZBbFThF4c09Fcz1C2_rMorxtXHzt4vy7coj6eyp_zt6EfLvxG-hKrnRk0mHg4Dav0FwqxBQ3sNW7Hz6-qcokX_BXo8msHQec5RnVPLVmZ6POZsh0Uwo8"),'
              //
              '("El patrón más famoso del universo", "Conceptos", "Desarrollo web", "none", "Un patrón legendario que separa datos, lógica y visualización. Es como tener un chef, un mesero y un cliente en nuestro código - cada uno hace lo suyo sin meterse en lo del otro. Asi de sencillo.", "Microsoft", "https://docs.microsoft.com/en-us/aspnet/core/mvc/overview", "https://blogger.googleusercontent.com/img/a/AVvXsEiX-EeJ1dFYBgTksPAPElYYHl2k0ndemlfpFWMPfVvWt-pbefoo0FjboG2LNzYJkwQq9Jn8f9Ytrv3HulKucs9jWIlIkyOorwmWlOlopu2-6SWsb1MIQdQTRJ-aaW5FZCeXCHS8FQgkkxsceh2RLb1Jl1C8XMrOfsGqTwSYwgnPVjh8E6T9QMNTS0Ky"),'
              //
              '("La arquitectura que domina Android: MVVM", "Conceptos", "Desarrollo mobile", "none", "Significa Modelo - Vista - Vista de Modelo. Google la adoptó y ahora todos la quieren. Esta arquitectura es como tener un traductor personal entre tus datos y tu interfaz, haciendo todo más fácil de mantener.", "Android Developers", "https://developer.android.com/topic/architecture", "https://blogger.googleusercontent.com/img/a/AVvXsEiX-EeJ1dFYBgTksPAPElYYHl2k0ndemlfpFWMPfVvWt-pbefoo0FjboG2LNzYJkwQq9Jn8f9Ytrv3HulKucs9jWIlIkyOorwmWlOlopu2-6SWsb1MIQdQTRJ-aaW5FZCeXCHS8FQgkkxsceh2RLb1Jl1C8XMrOfsGqTwSYwgnPVjh8E6T9QMNTS0Ky"),'
              //
              '("Clean Architecture: La de los pros", "Conceptos", "Desarrollo web, Desarrollo mobile", "Clean Architecture", "Esta belleza de arquitecture es el nivel máximo de organización en código. Imagina capas de cebolla pero en software. Cada capa protege tu código como un guardaespaldas.", "Uncle Bob", "https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html", "https://blogger.googleusercontent.com/img/a/AVvXsEjWXEF_9JBEP7P3YRQ_q5_QyHeO9xLg-IwyyGfjszHiLe8qMvNhURDnHylfPBX1pOhaxzBTLq6sR3ouqf4GOdR92xvbcckC9I5EcSCNOYvYefWoHdDRo0er9FjYI0fyz5Q8LgxG7qnWNIaYav34HPZm2zZRunVlENahCEA8I7lmAwxz2f8bKKPC8IgX"),'
              //
              '("El domador de datos salvajes", "Conceptos", "Desarrollo mobile, Desarrollo web", "none", "La pesadilla de todo dev: datos cambiando por todos lados. Redux, Riverpod, Provider y otros gestores son como Pokemon masters, pero en vez de pokemones, domestican el estado de tu app.", "Ensal", "https://medium.com/@dev.lalo.personal/explorando-los-diferentes-tipos-de-gestores-de-estado-en-flutter-el-bloc-es-mi-elecci%C3%B3n-b2ecb03d859", "https://blogger.googleusercontent.com/img/a/AVvXsEi9fKgVLzwSbLdU9mZiiYHzCUUAuUlEfzQFGvkz80UIXgalaEMy0D7LKhm4WFlov4FJLxQfOO7eGYO-SEURl8PZ6HTPpQf7nthgHuyy2M93398A5hnNUnX0ahdPU_ACRbblZQainMiIgvVmtMqKUKGzKznzpKQ4eABoEn2_XUdWcy8Uy-hRT-pE2N4Y"),'
              //
              '("¿Que es Docker?", "Conceptos", "Desarrollo web", "none", "Es un contenedor que empaqueta todo lo que tu app necesita. Es como tener una caja mágica que hace que tu código funcione igual en cualquier lugar del universo.", "Docker Docs", "https://docs.docker.com/", "https://blogger.googleusercontent.com/img/a/AVvXsEgtS4vav7Bb-99jLpiEpRKh4k6HpH1_5qFUmNu1VXMwgaEgJQDoNTXo3Ul2ki5mqu-7pACxJnJN_ASe9_63ek6SD11_R8zaFDkhy6ZejoFDqDuy9nOOW9lWgVKa9q2zsaZNjjYTwUihj9rpoA1mH-EzWk7_jwzeg_QMieH8NlLeTlSJMlmfo3z_W3HK"),'
              //
              '("Scrum: La metodología del caos ordenado", "Conceptos", "Desarollo de software", "none", "Scrum es un método tan efectivo que hasta la NASA lo usa. Sprints, dailys y retrospectivas - es como un juego de rol pero para hacer software épico.", "Scrum Guide", "https://scrumguides.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEi-nbL7ElFNMHeKgZ_DuIcvtf7s8lqBG-rNDkaqYZeKf-KFqExxGKnJTVtC6M5wUf2VOimuZwM1l86yEmiBsrBs0_3Rmzbaf-MGjoIWtP-GfibSxSQ00je3jT8hsjtpYLYHARymrAkC7Tc09kivDLZP0pZ3EQXqMyKKAjOyCoE_4LV7DobKg4aaIAsU"),'
              //
              '("Breakpoint: El detective del código", "Conceptos", "Desarollo de software", "none", "La herramienta secreta de todo programador pro. Es como poner una cámara espía en tu código para ver qué diablos está pasando por dentro.", "Mozilla MDN", "https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/debugger", "https://blogger.googleusercontent.com/img/a/AVvXsEja5Qz_mcez-x4c17LveucpMayAK-OZ9eo3Y9Jtj45vKmVGEh3RGffeLxL1NnyHR_naRCVVKkf0N8WPLFkrelnlleUFseDJijMv1FkHxF1Y79C-0VMxSpN_oIdB455rHVj6JlYfJZVz-HAo3ILHI6QwL47nFpnZyry5lQAWiSMtEkWBkRhMgoAP4GOe"),'
              //
              '("Dependency Injection: Inyección mágica", "Conceptos", "Desarollo de software", "none", "Un concepto tan poderoso que te hace sentir como un mago. Imagina poder cambiar piezas de tu app sin que nada explote - eso es inyección de dependencias.", "Martin Fowler", "https://martinfowler.com/articles/injection.html", "https://blogger.googleusercontent.com/img/a/AVvXsEjZ7iqOeYgQRmFg2N2j3rjfP175HmYoKbckQr_lpaE9E7ffgRgEXb19SSwaZHVgGj3Jh0c7b8IH9xS6gBnhc8j8fLlAlPUgyKHTgfQ69TkCiRLRRYZizIKsh7oAiuJ-wy5Zd7A8TlX3gOI5d6UjfVlrb6aPQIJOO1iOa5qh15Tie9dl4-BZW4tv0XWG"),'
              //
              '("CI/CD: El guardián de la calidad", "Conceptos", "Desarollo de software", "none", "Pipeline que automatiza todo: pruebas, despliegue, hasta hace café (bueno, eso último no). Es como tener un robot que revisa tu código 24/7.", "GitLab", "https://about.gitlab.com/topics/ci-cd/", "https://blogger.googleusercontent.com/img/a/AVvXsEhveSXkDKeomeYRZDbHYTLTxGQIrftC6zDAe8QAPzG0XhbXs1PKz__cHfUG2OEHVMkcNTPoDgvl6QU9iUk5UICFi3gFuIdWbJzu79CZmDNZB4xBLd6_zpUjyzVP-MH8W25mF6tA4cdKdoUtPX43VrkelPFV5vSOa3bCwRuM-wKZG9_VoYd-0l6nFVCU"),'
              //
              '("La magia del código asíncrono", "Conceptos", "Desarollo de software", "none", "JavaScript llevó la programación asíncrona a otro nivel. Es como tener poderes para detener el tiempo mientras esperas datos.", "JavaScript.info", "https://javascript.info/async-await", "https://blogger.googleusercontent.com/img/a/AVvXsEjBO_iMzI6RUMCR0CQp45V5Q4K8mCMyxbtCx6OmO2j2iIa1Lvss_AoCfwUORUQKHvw6xsKj-fTmKAug25iYOKmQWfgM-gP585CR9g0JncWMGaLHYY34QtL8ZP8cLHO_KsIB-Glzrk_RTTvj0bpGNVbhW7eOROUwFk4ZZurFtGltlZwzxUl5xqwVASgi"),'
              //
              '("El arte de las pruebas", "Conceptos", "Desarollo de software", "none", "Escribir pruebas antes que código suena loco, ¿verdad? Pues este método revolucionó la forma de desarrollar software de calidad.", "Kent Beck", "https://www.kentbeck.com/", "https://blogger.googleusercontent.com/img/a/AVvXsEiKh9--z2oPabZ63Bh5ErRHnoTZjGxBZr605Wknv31l0jo6dTzETshfL1FyDY2YUdZzqul-zvd_BunqXyuTD7p-3CSByQZBamrodonk6cOPtElwQjl73PhHoxC-ZxHtL9thognfjL45DfNsZ2etmdhyXFoq6vN3mIXb9VA6gmuiols87xBxHoYTF6G_"),'
              //
              '("API: El cerebro de la app", "Conceptos", "Desarollo de software", "none", "El intermediario todopoderoso entre tu app y el servidor. Como un traductor universal que hace que todos los sistemas se entiendan.", "REST API Tutorial", "https://restfulapi.net/", "https://blogger.googleusercontent.com/img/a/AVvXsEhow39mWwn9VXgP9KCd749j2-FlBLkUU7fYbIGSBP1MFEE4cyoyydEnFYW0H3fC6NDzn3PaXLhSAinvSRogWJWc72FflkBUQ-XucrlfAR33lEnxP0zPIYf-608MHOYAmPt8KfnlEDhUBBEju5i9AyIVgPxYYIEoOXv5BmjMICeWzgAYLc-xyyO1gGGU"),'
              //
              '("Git: La base de todo", "Conceptos", "Desarollo de software", "none", "El sistema que salvó millones de líneas de código. Es como tener una máquina del tiempo para tu software. Puedes volver a cualquier momento.", "Git", "https://git-scm.com/", "https://blogger.googleusercontent.com/img/a/AVvXsEh7ZjZog-qCpHWuPm03tsPdGW9j40ZZoEOEXU8Gb_69JB28rCbOhPSPVe3xLnPQvIYFXggbz4v8HwgKMr0c4BvPhNKf_mxf14SPSqHBi4WDKI203R_W2ath2ezmktv72ZCBiHvbAkxO1WHeZEcubVvPwcMQf2hNL5yKxwHmccgcq2kmUpg513_noNF9"),'
              //
              '("El bucle infinito", "Conceptos", "Desarrollo de software", "none", "Es el terror de todo programador novato. Es como entrar a un laberinto sin salida. Este maldito puede hacer que tu programa se quede dando vueltas para siempre, como un hámster en su rueda. ¡Y adivina quién tiene que sacarlo de ahí!", "Jimdo", "https://tutospoo.jimdofree.com/tutoriales-java/estructuras-repetitivas/ciclos-infinitos/", "https://blogger.googleusercontent.com/img/a/AVvXsEgCwBRdT0qM2qRZpKeCSg4xHpJY6_6x_m0Roxm6OLNH1WspTwvYIuCE4ze_mbCIoPILqR6cbZyKqo7V_BDES56T7jk42T3MKrf2PTUUTTfTlOvGJZuR-gmwg6ZvSX9OsN8BXKpeN81arpP3xveMNhhrg-r25w71iwClWT8pidSm-uT0PYPNUUoEGyU5"),'
//
              '("La recursividad", "Conceptos", "Desarrollo de software", "none", "Es como esa muñeca rusa que tiene otra muñeca dentro, y esa tiene otra, y así sucesivamente. Es cuando una función se llama a sí misma. Suena a locura, pero es una forma elegante de resolver problemas complejos. ¡Es como si el código se multiplicara solo!", "NetMentor", "https://es.javascript.info/recursion", "https://blogger.googleusercontent.com/img/a/AVvXsEjk7nrAmXWaIdG_3IXZrf1TVvEy4pbCohhOd6uiVSanoZQfy12woOFfHi3cOSWUlfQybTusIhdkgZk8OpsnLbfhkYL6zEzJlQwRvebJ0d8LlU2r8Ic_Rfmb13IH5lyV9oXTDNv88TVvWeFjtGJilqADmSqqTPHTC6Ln_ghcU9pZJRLoL0Tb9pT-wrgC"),'
//
              '("El temible NullPointerException", "Conceptos", "Desarrollo de software", "Java", "El NullPointerException es como el coco de Java. Aparece cuando intentas usar algo que no existe, como buscar en un cajón vacío. Este error ha hecho llorar a más de un programador y ha sido la causa de incontables noches sin dormir.", "Oracle Java Documentation", "https://docs.oracle.com/javase/8/docs/api/java/lang/NullPointerException.html", "https://blogger.googleusercontent.com/img/a/AVvXsEhh-mLIcRUuvpIIXHMDoiGzM3sWk8Bj9U23GBjsyQYBalUvOeDjHSWNMHPSyyhXkUoetaaujsZET8w47HkSzXoSIi3-g7Tok8jYotL5QouJ9i8N4B5qS9R-XXRXLKfiTlUzDz3GiVl_XPpeeIyQl8hibu_T9WAVtLhAXG4iVfERhNTcjPRgb3-fxTPv"),'
//
              '("El misterioso puntero", "Conceptos", "Desarrollo de software", "C", "Un puntero mal usado puede hacer que tu programa explote como si hubiera pisado una mina. Los punteros en C son como las coordenadas de un tesoro en el mapa de la memoria. Te dicen exactamente dónde está guardado un dato. Son potentes, pero peligrosos.", "cppreference.com", "https://en.cppreference.com/w/c/language/pointer", "https://blogger.googleusercontent.com/img/a/AVvXsEgIKoll2KtwMVyvu-QhEpesevMFb1Yy6v8zP8TiAP6kwXPAgGI8exMMk_ckFTxag6-xKDChHKhls6017rnpy5_wOhexgfh2fF8GVbQuXZCFWdI-fc17KIJCUuxvBc8-OpmuIPOEZRS5JwHfpVn_fVTmsD-QR0PNgN6QDPwQcb6e__RHaPxJmF2LRdXd"),'
//
              '("La bestia del multithreading", "Conceptos", "Desarrollo de software", "none", "Ojo: el multithreading es como intentar hacer malabares mientras montas en monociclo. Permite que tu programa haga varias cosas a la vez, como un pulpo tocando varios instrumentos. Suena genial, pero puede causar dolores de cabeza épicos si los hilos se pelean por los mismos recursos. ¡Es el arte de mantener la paz en el caos!", "Python Software Foundation", "https://docs.python.org/3/library/threading.html", "https://blogger.googleusercontent.com/img/a/AVvXsEizWydOVIa4itpRM-1t2OgaZzNj7IZnjrH7rKeF550cwN58LExMn221osvW9bdqzEc5jWglaNFHFV7gjO2vaR95reOekVrq7koQYxN8NqYRAsVCt0Ggs9_7v2oIfiXUyY7LD2BsPIh_KVEKH7mqEjvEzatiI_K7cFtTVCZ-8VIVKzMLBJSlbCpgzSK9"),'
              //
              '("El temido memory leak", "Conceptos", "Desarrollo de software", "none", "Es como una gotera en tu programa. Poco a poco, va consumiendo la memoria de tu computadora hasta que no queda nada. Es silencioso, lento y mortal. Antes de que te des cuenta, tu programa está más hinchado que un globo a punto de explotar.", "Intive", "https://intive.com/es/careers/memory-leaks", "https://blogger.googleusercontent.com/img/a/AVvXsEi3qwlPkZPAqg4maP8J-XadQ8f6gemPWxJPX4sVsoUWsXpUPT6z1dMAhzyMvtUdS4WyNVpR7VL2Ttq5Y7yru3J4K0gl7q5_0AQfH5xdN3-_UlT7qxqP6CShiQWvtjsgyKlTdPvaj0aGRcBYjztVvYOtMiiFG2CHzXDpp7ps0Z-8TL-2c7lM__grQtzP"),'
              //
              '("El enigmático lambda", "Conceptos", "Desarrollo de software", "none", "Pilas con esta: las funciones lambda son pequeñas, anónimas y mortalmente eficientes. Aparecen de la nada, hacen su trabajo y desaparecen sin dejar rastro. Son tan cool que hasta tienen su propio símbolo: λ.", "AWS", "https://docs.aws.amazon.com/es_es/lambda/latest/dg/foundation-progmodel.html", "https://blogger.googleusercontent.com/img/a/AVvXsEjRywPpbdOP3Zr49V2JClI2y68PQ9IMxi4v68bFQQEf_UJy7LAIR0XeXYjDhrhaPinlj6prlieeOiodfTuviq9szqPoADl9WcEWBjxhkpU3be5gsd1dnuIA7OB63lh6rc15qHEoJT0E2LEXQ-f9wCMDoj_DbaidetBg33bweo6xqVQldmOBgmiBJo1X"),'
//
              '("El poderoso polimorfismo", "Conceptos", "Desarrollo de software", "none", "Ojo al dato: el polimorfismo es como tener un control remoto universal para tus objetos. Permite que diferentes clases respondan al mismo mensaje de diferentes maneras. Es como si tuvieras un perro robot que puede ladrar, maullar o hacer el sonido que quieras. ¡La flexibilidad llevada al extremo en el mundo de la programación orientada a objetos!", "GeeksforGeeks", "https://www.geeksforgeeks.org/polymorphism-in-java/", "https://blogger.googleusercontent.com/img/a/AVvXsEgVWgUiaLK3iPjwd0pvKjPJnKOl0faG3nihpgSG5II6AtI5ulsaK2BUvQpuos9k2eKteU0DHFgthLKG1uoinsJP4vB6TmAgy34l_RFw9SwrTxPJ8nVMlc7XC1MFNdKXNX8OYaM1gEawqvSLZCOQ09hgC2zukWcgOKydggzGRKUwAf46BjI18g4y73Wt"),'
//
              '("La misteriosa sobrecarga", "Conceptos", "Desarrollo de software", "none", "La sobrecarga es una locura. Es como enseñarle nuevos trucos a los símbolos matemáticos. Puedes hacer que el + signifique lo que tú quieras. ¿Quieres sumar strings? ¿O tal vez concatenar listas?, se puede, tú decides.", "cplusplus.com", "https://cplusplus.com/doc/tutorial/operators/", "https://blogger.googleusercontent.com/img/a/AVvXsEiUFxQPWArZp_LpXzl4QSheadQTrJSV2mdbWk8N4CgbrP_CsXofQl7ylM0ZO_hBj2QjRPBIVMaEBp9vvku2eHHWD14-UF0Jrg1lrnCFmVeXFR8grqenS9-_hhSY_jJhZYMhZUdepFYCDFFAPKPNTW1D6IseDyKp7pItGcXf1RS-IV2ph_JsK8mHdhHE"),'
//
              '("El todopoderoso patrón Singleton", "Conceptos", "Desarrollo de software", "none", "Es como el rey absoluto de las clases. Asegura que solo exista una instancia de una clase en todo tu programa. Prácticamente es tener un dictador benevolente en tu código. Útil, pero con gran poder viene gran responsabilidad. ¡Úsalo sabiamente o terminarás con un monarca tiránico en tu aplicación!", "Refactoring Guru", "https://refactoring.guru/design-patterns/singleton", "https://blogger.googleusercontent.com/img/a/AVvXsEiWTlF2v_f2vUW_ZH3ZgnXsP9StkjcYsaJvwZsaeW-ImQ0Cuhl2oW3NhXkBzEMNroVgwcSTd5qDSzK8V8PV-5zIQdQkoI1Y31teruHqH9rUpoer2EHiV1DtUbi-0QajrYUKuy8lrKgZwCtrhSEgHuNgIoSwqyJuSErh3ypWanzKJmjdymWwj8uYlDj9"),'
//

              // Tips y Salud
              '("¿Sabias que existe un truco llamado patito de goma?", "Tips", "Desarrollo de software", "none", "El Rubber Duck Debugging no es una broma. Consiste en explicarle tu código línea por línea a un patito de goma. Esa vaina funciona. Al explicarlo en voz alta, puede que encuentras el error sin que el patito diga ni pío.", "BrainSchool", "https://www.thebrain.school/metodo-patito-goma/", "https://blogger.googleusercontent.com/img/a/AVvXsEigD8O5TcCnkt1u5cJNWwgx8D08igKw7TNVLpXzDRcG9ZniBdLMS7dXCK3v1Xzc4J1fx142OKe9L452ypAGS7xMinuvSR1o2mf7OHh0NB6U6bXgZRarjm1Qkqr_g8mAX9jYNUiV-IjNMXD6u8VcbHuRjtQv5aVoQZFICWtoH3GHu6vMdoAHJJFhppY9"),'
//
              '("La regla del 20-20-20", "Tips", "Desarrollo de software", "none", "Entiende esto. Cuando programes, cada 20 minutos mira algo a 6 metros de distancia durante 20 segundos. Este truco de los oftalmólogos ayuda a prevenir la fatiga visual. Es como darle un mini-descanso a tus ojos. Sino, luego no llores cuando seas miope.", "American Optometric Association", "https://www.aoa.org/healthy-eyes/eye-and-vision-conditions/computer-vision-syndrome", "https://blogger.googleusercontent.com/img/a/AVvXsEg_AGHkmWqpVpsjVP9WTrQAULmwgYe1sDzG_gIh6bYgm9z3ovAfUIE_BMxN2pij-N48l0KBfct2lwD-r-6Io2sLYrnA76Vmg2uNBhQamMpr52Ffnj56RV5Y7Bk2dICXau2ppxCuscFXhnhVbUaVj10Gq9tBw7zoX5Tr7Ib0mGF0ErABCD6eF2m-WOKP"),'
//
              '("El arte del Zen Coding", "Tips", "Desarrollo de software", "HTML/CSS", "Esto te va a volar la cabeza. con Zen Coding (ahora llamado Emmet), puedes escribir HTML y CSS a la velocidad del rayo. Pones una abreviatura y ¡bam!, se expande en código completo. Es la forma express de escribir markup. ", "Emmet Documentation", "https://docs.emmet.io/", "https://blogger.googleusercontent.com/img/a/AVvXsEhzoL0MygLvZT4vuSDfKT6B43hNyhZCXWGIKcadrpUgAvPo5zjf0Q_euPj4ZbwC6AwXHlSkfz35lurOkH5uqp1Di4rusaNQWLlSX8_cFq8tNtk7GGNfgApp5mGlCTdREkY-IJc9fYq0Sbv65PT9MA_Fk5HHcEj231QEGk0Ux9yJvGVBiJuNxC8LVA9x"),'
//
              '("La técnica Pomodoro", "Tips", "Desarrollo de software", "none", "Deja la pereza. Trabajas intensamente durante 25 minutos y luego tomas un descanso de 5. Haces intervalos de alta intensidad, pero para tu cerebro.", "IEP", "https://iep.edu.es/que-es-el-metodo-pomodoro/", "https://blogger.googleusercontent.com/img/a/AVvXsEgqDmxMtJ6xK9Ta24zsny3BUIWM4EGzxPNDiSrF0pqVTitQlsF3FeX8N69EeEgvQN7aHDaqj3jW0GZR-c4vzL2fHLQ2biXZ_p6KxWcrtrcXAVu85MfXT5t28n72kHVqyiLpfYC4t7blw4ghMyi4EqDqIe7rvzNuXxR-Nv7kYaFo9r0yD7o9WB0MDHH8"),'
//
              '("La magia de la programación en pareja", "Tips", "Desarrollo de software", "none", "Esto es una locura: la programación en pareja es tener un copiloto al trabajar. Uno escribe, el otro observa y sugiere. Juegan al bueno y el malo pero con bugs. Reduces errores, compartes conocimiento y tienes a alguien con quien celebrar cuando finalmente arreglas ese error que te estaba volviendo loco.", "Nimblework", "https://www.nimblework.com/es/agile/programacion-en-pareja/", "https://blogger.googleusercontent.com/img/a/AVvXsEjNwdIplAXGXCz7qqgyimWQOmD-xMJNSUVKH_4JUHvbGTd-odqZRWifBEGzpJt6KycmyPO9le6NIsiEiwNRmKhMg0OPHbm19SF0n1mVRKzBcrdPCMRQsZN8B9Vbn6tuL15Eo4X1CxU5nQRV2lcGbuz0VGqeyo7BfXkF-KX2S0loAofk9Z59ojnHmeaQ"),'
//
              '("El truco del comentario TODO", "Tips", "Desarrollo de software", "none", "A ver, genio. Usar comentarios TODO es como dejar notas Post-it en tu código. Te recuerdan esas pequeñas tareas que necesitas hacer pero que no son urgentes ahora. ¡Pero cuidado! Si abusas, tu código se volverá un mural de cosas por hacer. Tampoco seas cochino.", "Python Software Foundation", "https://peps.python.org/pep-0350/", "https://blogger.googleusercontent.com/img/a/AVvXsEiYIuYBNNIq34YhgjMNLu6sqY7U2cys4QHVZtFYdmDgV6ikQzO3vsAOLyGFzTG8YMujCMq4QgE7N9qNGSla1oMlVSswIGz1GkwAzw7sNZMHUafAm4cWq7syhzgDd-EZQQVFpxmeIGGVeuNg-jA-txDz4m0f0StMVDqtgCQhVAUVNwOAfZt44Bj7U2Y2"),'
//
              '("La recursividad explicada recursivamente", "Tips", "Desarrollo de software", "none", "Para entender la recursividad, primero debes entender la recursividad. ¿Confundido? ¡Perfecto! Acabas de experimentar la recursividad. Inception ricolino.", "Khan", "https://www.khanacademy.org/computing/computer-science/algorithms/recursive-algorithms/a/recursion", "https://blogger.googleusercontent.com/img/a/AVvXsEgqPWf4api6kfeqAtB2K_zd9DE8YeshqFLJVzsYrufvVkR_834lr2vddy5TcWRF7EnUgq1c3t-TWuPUnGYw45kvEDzum4vj24-DCSprkPcp4LxA3Q40mTeaNio0UdKgy9HBZdQTSvZpOEwLZRRc3AX8HcBk_ZsVv05X0_qJWtIjtHPJaoM2riZcPzZo"),'
//
              '("El secreto del debugging", "Tips", "Desarrollo de software", "none", "El 90% del debugging consiste en encontrar el error. El otro 10% es arreglarlo. Simple. Es como buscar una aguja en un pajar, excepto que la aguja está hecha de código y el pajar es más código. La clave está en usar breakpoints, logs, y tu cerebro: estrénalo.", "AWS", "https://aws.amazon.com/es/what-is/debugging/", "https://blogger.googleusercontent.com/img/a/AVvXsEiqfpTH77U_Q6u4gqDPEvjn56feQLf-aQ12nFJJJqIzgo0Ymnr5chD-VwqCpODGZpsuKZoxtq2nrJcQsXV4O1WI0hL5uotj8auDNdMDPGI4MwQyZFqecMidQDF4ji5FXoshIQn_C3DnLhW81zA9r4fcnRmYnISZH8MP2nmksJ4cEMmbi55OrTY5uiu4"),'
//
              '("La regla del Boy Scout", "Tips", "Desarrollo de software", "none", "Esta regla a regla dice: Deja el código más limpio de lo que lo encontraste. No seas cochino. Sé un Robin Hood del código: mejoras un poco cada vez que pasas por allí. Con el tiempo, incluso el código más putrefacto se vuelve hermoso.", "Devtia", "https://devtia.com/post/codigo-limpio-la-regla-del-boy-scout#:~:text=Como%20ya%20te%20habr%C3%A1s%20podido,de%20lo%20que%20te%20encontraste.", "https://blogger.googleusercontent.com/img/a/AVvXsEjm7Fk3eKzP3YwkMR9moZqKMsRYKi41UouZCAgCdx2nVFsobw7yFCA2r0sLccBPROihJ6gUlGHHEoJsDUy8anl-nPEDtTIg8irg8pIsV_dRrkD2vvl5I2xuvTcE0Io3ZeexxxtdIqYdR-WR_7L1Srm4DSM-sNrv-Vegu50xDGfmItlM17a6yMeStbND"),'
//

              // Curiosidades
              '("Lenguaje esotérico Brainfuck", "Curiosidades", "Tecnologias", "Brainfuck", "Es un lenguaje de programación esotérico con solo ocho comandos, diseñado para ser lo más difícil de programar posible.", "Wikipedia", "https://es.wikipedia.org/wiki/Brainfuck", "https://blogger.googleusercontent.com/img/a/AVvXsEh9rEkocL3u7EBCcjw0HdHIjt2bWG6Uqz5Boi-J9LXzh7mTz5MpqQvc8zPsiEVyZjc1lsJhgjC3lGTlAM_RmSUOuwf6F4bdR4E1gju4gtZKYSYf92ApV5gUCL5anWwjCr_G8igrZDXUrnMwCdCsdWglUP9ctJ1RBrAJUC8CGB60pM1zpJSaezkcC_Zl"),'
              //
              '("Lenguaje Piet", "Curiosidades", "Tecnologias", "Piet", "Piet es un lenguaje de programación visual donde los programas son imágenes abstractas que ejecutan código en función del color y la disposición de las regiones.", "Esolangs", "https://esolangs.org/wiki/Piet", "https://blogger.googleusercontent.com/img/a/AVvXsEj9Vdv_T_e_2gdLU-5_HGXfeA2lr_Nw38P2JU-f4ahP_KKqCtp_-Kn335HUKmpDYOLnbWZyMiOXetzuhb4JwzM9IyVAr6CeL_6meVnvqTjkjTlIMnYqAeYGethvc8cOYP9ovWm6Xs9iUaurUU93DHQm1pPsZ0VFIbezSS6EkTV0Jy4RhnXrttLIVHWI"),'
              //
              '("Lenguaje Befunge", "Curiosidades", "Tecnologias", "Befunge", "Befunge es un lenguaje de programación donde el código se organiza en una cuadrícula bidimensional, permitiendo que el flujo de control se mueva en cualquier dirección.", "Microservicios", "https://www.microsiervos.com/archivo/ordenadores/befunge-lenguaje-programacion-raro.html", "https://blogger.googleusercontent.com/img/a/AVvXsEiqBuDbjZ2F9rCIqfv_sPY1I3FzdBNQxHpwY2pzMoZJ2vJ-hlTeeUyQ56uu6GjcbViSaXqNfBl8cz5_T3Ie1crhyLIpF0s9GuNZJnXxNyP03HUSZvcDL7lMUyve_1TZ-zi31Wzrr7DLsWY9g6GJJJ4joMwzsu_9gEwrzzgXMNL88r0Qzanui5hVRxJ6"),'
              //
              '("Lenguaje Malbolge", "Curiosidades", "Tecnologias", "Malbolge", "Es conocido como el lenguaje de programación más difícil de escribir, diseñado de manera que incluso escribir un simple Hello, World! sea extremadamente complejo.", "Esolangs", "https://esolangs.org/wiki/Malbolge", "https://blogger.googleusercontent.com/img/a/AVvXsEguOR7Y3HxHK47nkQfBoXhrnq_7dk2gtxX78d4dLUPt3yd-zYv7dAPw-bySKzTwdPVSj0jUocqX8cwYUr6_XmUxN-jYBk8KYKMdTYgFAazbKrp3ytBACfAXAaB6E7r7Kvb0ouULRl3ot0T_iWHEGsnkV0ewuNL_QSJw2DwHvaH6-9DW1eKINFYakeqR"),'
              //
              '("Lenguaje LOLCODE", "Curiosidades", "Tecnologias", "LOLCODE", "LOLCODE es un lenguaje de programación inspirado en los memes de gatos LOLCats, con una sintaxis que imita el estilo de escritura de estos memes.", "Wikipedia", "https://es.wikipedia.org/wiki/LOLCODE", "https://blogger.googleusercontent.com/img/a/AVvXsEiBxbYVUWCEYYkWHwTfAn0jcSsHvXdOtD1Oa9fLsBymR5DMJOB4DAYcYpoC5Ez-2PnTGWyq5db0Aov_B5sv3Q2JN1aZsoOCpKMLTJL2hhJ7F3PIwqI4BEoltvaCuRXAfhfnTKxq3aR81HzDN7vIm6nhuEy8utL4rcyki1PEDkrS3iqGtOWGncjvSmoN"),'
              //
              '("El origen del nombre de Python", "Curiosidades", "Tecnologias", "Python", "Python fue nombrado así por el grupo de comedia británico Monty Python.", "Python Software Foundation", "https://www.python.org/doc/essays/foreword/", "https://blogger.googleusercontent.com/img/a/AVvXsEjvJY_l7jfPkDugcr10ie10v8QqIlAZ0eSNvJDK-q8tYXlWD2rK3LXY6lCvS6GHt01iyZLW5pmLwK4dmXdFH_DvkWtBN14sWkr4jORVCfHvl5IqCd3vq4HuKi6Rbe4mSiSzTT08MKB0DSPFjQp-qN0awtHp7yXev_H2As5pMIeJ-D2YKQyfz_wkabmk"),'
              //
              '("El lenguaje Ada", "Curiosidades", "Tecnologias", "Ada", "Ada es un lenguaje de programación diseñado para sistemas críticos de seguridad, como los utilizados en la aviación y la defensa.", "AdaCore", "https://www.adacore.com/about-ada", "https://blogger.googleusercontent.com/img/a/AVvXsEh5dXG9_Op4kxKUxknOa9XvQ__hnDMvVBpxT8v0h1Hrjmx3cc-f72RdsSySoXNCMbE_kbUEViN0XYZtbZ_6tj2gYwfDwNeSJaESlRGX8935NtUeM3Ecv-ztHYw0TB-PMUmHYwqfiGJmpZjPL9D2BAmOpAxglck0GUANj8gzCjJ2AaZDWbR9MXOSfBGI"),'
              //
              '("El lenguaje Haskell", "Curiosidades", "Tecnologias", "Haskell", "Haskell es un lenguaje de programación puramente funcional, conocido por su fuerte sistema de tipos y su capacidad para manejar funciones de orden superior.", "Haskell", "https://www.haskell.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEiI4PXF8Xv3H68x7zZTUWO4YeKOfeGh6gIe2GDZ0S7c_DhF5lIybuS6EYbMokAMmT0eOOWFYl-Nc7njoEJ_af1X7YcLywkyz6AjdBEb66bouOQJOYM7ADU09RR1ZWJu-8sfSQM_yJNVctPcZbj6T6JawbC1ap9tQ0Ro777CPm6Acexpz6nsZsUmaPqW"),'
              //
              '("El lenguaje Erlang", "Curiosidades", "Tecnologias", "Erlang", "Erlang es un lenguaje de programación diseñado para sistemas concurrentes y distribuidos, utilizado principalmente en telecomunicaciones.", "Erlang", "https://www.erlang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEgyUBXtcCFotY69Zawq1p3fA2v89NKO3RUUQJqxFcsok3s8DjkUJzSXJ9ipTViLRPqTRmzslNCscTmPLUjTKjnf3EZxYunzk-x6gXWD6br341MQ9miecmxb2gGcbb3_q8Yme2p1ZEd84us9UzOb3--r38PxEIGqbFI13dE32SxUSDTqYpSWO2UqjgS1"),'
              //
              '("El lenguaje Forth", "Curiosidades", "Tecnologias", "Forth", "Forth es un lenguaje de programación utilizado en sistemas embebidos y de tiempo real, conocido por su eficiencia y flexibilidad.", "Forth", "https://www.forth.com/", "https://blogger.googleusercontent.com/img/a/AVvXsEgiSgBa9MIUn8OPX5BJ4DBKiXTuU8UOAnI86HVwcyD7WatbHgIyfYY8NiaDJqSfhzdujgId-YPJdRaU2R4hy-VsidRWGUmlfOhibtXGscoTKHshucL4Z8Bs7snLVfoxNdbRgFeE32ADp24NQz7M1BjaMK-VMZCdJQDV4xineRBvUg7OMq1rCcjmLfab"),'
              //
              '("El lenguaje Prolog", "Curiosidades", "Tecnologias", "Prolog", "Prolog es un lenguaje de programación lógico utilizado en inteligencia artificial y procesamiento de lenguaje natural.", "SWI-Prolog", "https://www.swi-prolog.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEi5Skk3INxgcb7Z1K6c7U_oD33LLt8fRJBweGFsB6A2ksrhn8Ctx89p0P-g9ooAPH6LJC9RS0Xc7AHygzZhwhYrm97QnyLnsDs3Uacls0OM8wjcQ7xipcIpOx-NN7AvPZUEuyKrU3AV2s1DKO0mNADDsz45aq6e0P-Pz307964oWRdiAHqIwi9q-93Z"),'
              //
              '("El lenguaje Lua", "Curiosidades", "Tecnologias", "Lua", "Lua es ampliamente utilizado en el desarrollo de videojuegos, especialmente en motores como Corona SDK y en la creación de mods para juegos como World of Warcraft.", "Lua", "https://www.lua.org/about.html", "https://blogger.googleusercontent.com/img/a/AVvXsEhvBeZw2AfhHhF-o6oG-WAt0yunYaQF7HsxDTBvyL_Gzd6i9fjk3u1eLZh-dmsel4l6XV2w8IHaGVr12kv7PV7LzGdx1kuPb53Uh2DS-WE_xLgNbYVVhBb5wtommgfP-JJ4bCt31p5nDdm3cDRmJpM4BrZIZgyQJcJMtfWYfqfEWJx6rPeenEZW2vXE"),'
              //
              '("El lenguaje Racket", "Curiosidades", "Tecnologias", "Racket", "Racket, derivado de Scheme, es un lenguaje multiparadigma utilizado principalmente en la educación de ciencias computacionales y para crear otros lenguajes de programación.", "Racket-lang", "https://racket-lang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEgzG08No1tFf2ZEGQ_Vj3WmlpzUxfLXhWxaprLwn0CctOdNBvgyWQCfLcIdsnn-0DB6BejmV4qE-TaG4wc2GqoKSlxj05oEko64Bt1CYNDH_Mk7-C9rNym7l3F4bsykp93joFxGNR1Fqs8FqV8Qu6gA0CSX_EcAXMIHZUM56ZL98dvdGOGMIPf4A_Qi"),'
              //
              '("El lenguaje Nim", "Curiosidades", "Tecnologias", "Nim", "Nim combina la eficiencia de C con la expresividad de Python y la elegancia de Lisp, siendo especialmente valorado en el desarrollo de sistemas.", "Nim-lang", "https://nim-lang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEhQibHdEL0IWvizTiNi4XUBAqm7ZmL3o9YgeRI6gPMR2hxU_0iOZtpe8GiAAkcnes4j7H2J38c9BhFc4XOXg3O0vk4_iwthJQECWdNhw58pYapGXzXA47aXa56lsWGJFb5GChr54LKSmRSvGhOyy0zFuI4fIST4Kvrp29SY41DDxdOlTUgpEVUJmW5e"),'
              //
              '("El lenguaje Haxe", "Curiosidades", "Tecnologias", "Haxe", "Haxe es un lenguaje de programación versátil que permite la compilación de código en varios lenguajes, incluyendo JavaScript, C++, y C#, siendo popular en el desarrollo de juegos y aplicaciones web.", "Haxe", "https://haxe.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEjv08pAehfmflgAyLv44RvBHoE7HQm_LNtN5P24Leg1Cngfto6rtkQxMBBHPQYSBUNf_e2DUNNwwPYX-PAk0c4Kl0H7xal5FQV82-vvDHXpGvXlFSAIrmDNBDVl9i6VqjsyG2RGUJ_X0I6l0jWeAaLbV335IrdLyRt33hSu-wUINROVHLn03chRuyZc"),'
              //
              '("El lenguaje Elixir", "Curiosidades", "Tecnologias", "Elixir", "Elixir es un lenguaje funcional, construido sobre la máquina virtual de Erlang, conocido por su capacidad para construir aplicaciones distribuidas y tolerantes a fallos.", "Elixir-lang", "https://elixir-lang.org/", "https://blogger.googleusercontent.com/img/a/AVvXsEiR1kOi0E6OaN8L_bCGcMozDW3I5RK-Yegdkzy71C58zr6OmTYGyKETQrGZ7_MMzEdm9YMz-7r_eUy73PrLTI_ti9OlgJyc0DqlRclpjzX5fEAdhko5YoI-SjFTZup3q81y47pwQylVyfEHbg-oj20Em3Ozqj1lElCtJeK59RwaCnjLqA1iNu53LEoz"),'
              //
              '("El lenguaje Whitespace", "Curiosidades", "Tecnologias", "Whitespace", "Whitespace es un lenguaje de programación que usa solo espacios, tabulaciones y saltos de línea.", "Mozilla.org", "https://developer.mozilla.org/es/docs/Web/CSS/white-space", "https://blogger.googleusercontent.com/img/a/AVvXsEi26ydQXOO0SnyUXdZDSMDHWEMotIaV6XAO3dhOv-HJBHDWePJ3hx1dsKDgW_TaSlS1zuuwqFYD8qiy-JddsKjr9CJNUOECudcl57yLpnTHtZJL3gvrusytt7bY0_07ZM9audO3U6uzsDDVLVV4aPM2hzBVDchNEX8Y7cpiSZu7MKM6OzzkI-BdR1tE"),'
              //
              '("Java y sus 3 mil millones de dispositivos", "Curiosidades", "Tecnologias", "Java", "Java se ejecuta en más de 3 mil millones de dispositivos, incluyendo smartphones, cajeros automáticos y electrodomésticos.", "Oracle", "https://www.oracle.com/java/technologies/", "https://blogger.googleusercontent.com/img/a/AVvXsEgXRAceKO3lMGRHFWb--JdLmFkTntkjYX1PGZ_w8vebT6xw0U9tA45yYYYxK0I6AunE_3dIIWcXywr7SWyDzDhCaOwkWgMp32D7y_xVhdsem2ro45uLKVxZDZnZsjtULejR-h14cPrW_90JkJvlXGAhSPEUiiqe8iwznazxyeRW_autSSQfa7dn5zMC"),'
              //
              '("¿Quién popularizó el famoso Hello, World?", "Curiosidades", "Desarrollo de software", "none", "El mensaje Hello, World! fue popularizado por el libro de Brian Kernighan sobre C, mostrando un primer programa básico.", "CodeInterview", "https://codeinterview.io/blog/the-history-of-hello-world-a-brief-overview/", "https://blogger.googleusercontent.com/img/a/AVvXsEjwen6811Ti-u4N9QVIMf04t9EgYo86fjajX1i2rg7YjmKsIUCsQdFPxw6AzmWkCmGFVUIKftLDIzGQ4DX7jQyDvyDIK7Nix3cBoZDrciHei_CWnBcjiY4bYZk19PwLPTW6pQTpTNlzI1N2dKu0cyrEh_EpPya1o15WGGMbPf_S69tAPa0RdOstJ-T9"),'
              //
              '("El origen accidental de JavaScript", "Curiosidades", "Tecnologias", "JavaScript", "JavaScript fue creado en solo 10 días por Brendan Eich en 1995, originalmente llamado Mocha.", "Mozilla", "https://developer.mozilla.org/en-US/docs/Web/JavaScript/About_JavaScript", "https://blogger.googleusercontent.com/img/a/AVvXsEg2nabFJ05Gtuuqj8ZMUgKuBMBMAZvVH13ViGBhRpj3frDrJ4_oORNZ3eCgIKu3Tzx-wX8pqn4UAI1u1uXBD794Xa8PHo8ji4OcnTSnmzoOLyh8s5sg6Ihr8FblQ-rw0gd-UkOhdxLl6xHic722ObFQ9FZR5RSJDlZitL-ApjfXqVXjkMAsNs3coR8y")';

          await db.execute(addFacto);

          deleteOldDatabases();
        },
        version: 1,
      );
    } catch (e) {
      throw Exception('Error al inicializar la base de datos: $e');
    }
  }

  Future<void> deleteOldDatabases() async {
    for (int i = 1; i < dbVersion; i++) {
      String dbName = 'facto_database_$i.db';
      await deleteDatabase(dbName);
    }
  }

  @override
  Future<List<FactoModel>> getAllFactoList() async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult =
        await db.rawQuery('SELECT * FROM factos');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> blackList = prefs.getStringList('blackListFactos') ?? [];

    List<FactoModel> allFactos = queryResult
        .map((e) => FactoModel.fromJson(e))
        .where((facto) => !blackList.contains(facto.title))
        .toList();

    return allFactos;
  }

  @override
  Future<int> countFactos() async {
    final db = await initDb();
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM factos');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  @override
  Future<List<String>> getAllPreferenceFacto() async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult =
        await db.rawQuery('SELECT preference FROM factos');

    return queryResult
        .map((map) => map['preference'] as String)
        .toSet() // Convierte a Set para eliminar duplicados
        .toList() // Convierte de vuelta a List
      ..sort(); // ordena la lista alfabéticamente
  }

  @override
  Future<List<String>> getAllCategoryFacto() async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult =
        await db.rawQuery('SELECT category FROM factos');

    return queryResult
        .map((map) => map['category'] as String)
        .expand((category) =>
            category.split(',')) // Divide las preferencias con comas
        .map((word) =>
            word.trim()) // Elimina espacios en blanco al inicio y final
        .where((word) =>
            word.isNotEmpty &&
            !word.contains(',')) // Filtra palabras vacías y con comas
        .toSet() // Convierte a Set para eliminar duplicados
        .toList() // Convierte de vuelta a List
      ..sort(); // Ordena la lista alfabéticamente
  }

  Future<List<FactoModel>> getFactoListFilter() async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult =
        await db.rawQuery('SELECT * FROM factos'); //[pref1, pref2, pref3]
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }

    return queryResult.map((e) => FactoModel.fromJson(e)).toList();
  }

  Future<List<FactoModel>> getFactosListByWord(word) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Lista para almacenar los resultados
    List<FactoModel> factosList = [];

    final db = await initDb();

    final List<Map<String, dynamic>> queryResult = await db
        .rawQuery('SELECT * FROM factos WHERE title LIKE ?', ['%$word%']);

    // Convertir los resultados de la consulta a objetos FactoModel y añadirlos a la lista
    factosList.addAll(queryResult.map((e) => FactoModel.fromJson(e)).toList());

    return factosList;
  }

  Future<List<FactoModel>> getFactosListFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> titles = prefs.getStringList('titles') ?? [];

    // Lista para almacenar los resultados
    List<FactoModel> factosList = [];

    final db = await initDb();

    // Consultar la base de datos para cada título
    for (String title in titles) {
      final List<Map<String, dynamic>> queryResult = await db
          .rawQuery('SELECT * FROM factos WHERE title LIKE ?', ['%$title%']);

      // Convertir los resultados de la consulta a objetos FactoModel y añadirlos a la lista
      factosList
          .addAll(queryResult.map((e) => FactoModel.fromJson(e)).toList());
    }

    return factosList.reversed.toList();
  }

  @override
  Future<List<FactoModel>> getListPreferenceFacto(preference) async {
    final db = await initDb();
    final List<Map<String, dynamic>> queryResult = await db.rawQuery(
        'SELECT * FROM factos WHERE preference like ?', ['%$preference%']);
    Map<String, dynamic> result = {};
    for (var r in queryResult) {
      result.addAll(r);
    }

    // return queryResult.map((e) => FactoModel.fromJson(e)).toList();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> blackList = prefs.getStringList('blackListFactos') ?? [];

    List<FactoModel> allFactos = queryResult
        .map((e) => FactoModel.fromJson(e))
        .where((facto) => !blackList.contains(facto.title))
        .toList();

    return allFactos;
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
}
