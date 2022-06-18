import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

export '../models/pokemonmodels.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database?> get database async {
    _database = await initDB();

    return _database;
  }

  List<dynamic> scans = [];

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'pkemonDb.db');
    //print(path);
    // Crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
CREATE TABLE equipo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    poc1 int NOT NULL,
    poc2 int NOT NULL,
    poc3 int NOT NULL,
    poc4 int NOT NULL,
    poc5 int NOT NULL,
    poc6 int NOT NULL)
    ''');
    });
  }

  Future<int?> insert(String nombre, List<dynamic> pokemon) async {
    final db = await database;
    //print(pokemon);
    final res = await db?.rawInsert('''
      INSERT INTO equipo(nombre, poc1,poc2,poc3,poc4,poc5,poc6 )
        VALUES('$nombre', ${pokemon[0]}, ${pokemon[1]}, ${pokemon[2]}, ${pokemon[3]}, ${pokemon[4]}, ${pokemon[5]})
    ''');
    scans = [res];
    return res;
  }

  Future<dynamic> getequipopokemon() async {
    final db = await database;
    final res = await db?.rawQuery('''
      SELECT * FROM equipo    
    ''');
    //scans = [res];
    return res;
  }

  Future<List<dynamic>> getTodosLosScans() async {
    final db = await database;
    final res = await db!.query('equipo');
    scans = res;
    //print(scans);
    return res;
  }

  Future<int> deleteEquipo(int id) async {
    //print(id);
    final db = await database;
    final res = await db!.delete('equipo', where: 'id = ?', whereArgs: [id]);
    //final res2 = await db.query('equipo');
    //scans = res2;
    return res;
  }

  /*Future<Map<String, Object?>> getequipopokemon(int id) async {
    final db = await database;
    final res = await db?.query('equipo', where: 'id = ?', whereArgs: [id]);

    return res!.first;
  }*/
/*
  Future<ScanModel> getScanById( int id ) async {

    final db  = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
          ? ScanModel.fromJson( res.first )
          : null;
  }

  Future<List<ScanModel>> getTodosLosScans() async {

    final db  = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];
  }

  Future<List<ScanModel>> getScansPorTipo( String tipo ) async {

    final db  = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'    
    ''');

    return res.isNotEmpty
          ? res.map( (s) => ScanModel.fromJson(s) ).toList()
          : [];
  }


  Future<int> updateScan( ScanModel nuevoScan ) async {
    final db  = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [ nuevoScan.id ] );
    return res;
  }

  Future<int> deleteScan( int id ) async {
    final db  = await database;
    final res = await db.delete( 'Scans', where: 'id = ?', whereArgs: [id] );
    return res;
  }

  Future<int> deleteAllScans() async {
    final db  = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans    
    ''');
    return res;
  }
*/
}
