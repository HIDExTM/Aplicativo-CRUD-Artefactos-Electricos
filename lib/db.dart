import 'package:ep02ejercicio02tokumotomora/artefacto.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> _openDB() async {
    sqfliteFfiInit(); // Inicializar sqflite_common_ffi
    databaseFactory = databaseFactoryFfi; // Establecer la fábrica de la base de datos

    return openDatabase(join(await getDatabasesPath(), 'artefacto.db'),
        onCreate: (db, version) {
      return db.execute(
        "Create Table artefacto (id INTEGER PRIMARY KEY AUTOINCREMENT, descripcion TEXT,modelo Text,precio TEXT)",
      );
    }, version: 1);
  }

  static Future<int> insert(Artefacto artefacto) async {
    Database database = await _openDB();

    return database.insert("artefacto", artefacto.tomapI());
  }

  static Future<int> delete(Artefacto artefacto) async {
    Database database = await _openDB();

    return database
        .delete("artefacto", where: "id = ?", whereArgs: [artefacto.id]);
  }

  static Future<int> update(Artefacto artefacto) async {
    Database database = await _openDB();

    return database.update("artefacto", artefacto.tomap(),
        where: "id= ?", whereArgs: [artefacto.id]);
  }

  static Future<List<Artefacto>> artefacto() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> artefactoMap =
        await database.query("artefacto");

    return List.generate(
        artefactoMap.length,
        (i) => Artefacto(
            id: artefactoMap[i]['id'],
            descripcion: artefactoMap[i]['descripcion'],
            modelo: artefactoMap[i]['modelo'],
            precio: artefactoMap[i]['precio']));
  }
}
