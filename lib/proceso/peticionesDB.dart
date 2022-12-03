import 'package:geolocator/geolocator.dart';
import 'package:sqflite/sqflite.dart' as sql;

class peticionesDB {
  static Future<void> CrearTabla(sql.Database database) async {
    await database.execute(""" CREATE TABLE  posiciones (
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      localizacion  TEXT,
      fechahora TEXT
    )""");
  }

  /////  ///

  static Future<sql.Database> db() async {
    return sql.openDatabase("geo.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await CrearTabla(database);
    });
  }

  /////  ///

  static Future<void> guardarPosicion(locali, feho) async {
    final based = await peticionesDB.db();
    final datos = {"localizacion": locali, "fechahora": feho};
    based.insert("posiciones", datos,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  /////  ///

  static Future<void> EliminarPosicion(int idpos) async {
    final based = await peticionesDB.db();
    based.delete("posiciones", where: "id=?", whereArgs: [idpos]);
  }

  /////  ///
  static Future<void> EliminarTodasPosiciones() async {
    final based = await peticionesDB.db();
    based.delete("posiciones");
  }

  /////  ///

  static Future<List<Map<String, dynamic>>> MostrarPosiciones() async {
    final based = await peticionesDB.db();
    return based.query("posiciones", orderBy: "fechahora");
  }

/////////////////////////////
  static Future<Position> determinarPosicion() async {
    LocationPermission permiso;
    permiso = await Geolocator.checkPermission();
    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
      if (permiso == LocationPermission.denied) {
        return Future.error("Permiso Denegado para usar  el GPS");
      }
    }
    if (permiso == LocationPermission.deniedForever) {
      return Future.error(
          "Permiso Denegado permanentemente para usar  el GPS en este MOVIL");
    }
    return await Geolocator.getCurrentPosition();
  }
}
