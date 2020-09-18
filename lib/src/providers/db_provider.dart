import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrreader/src/models/scan_model.dart';


class DBProvider {

  static Database _dataBase;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase;

    _dataBase = await initDB();
    return _dataBase;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database database, int version) async {
        await database.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'type TEXT,'
          'value TEXT'
          ')'
        );
      }
    );
  }

  
  // ***+***** CREATE RECORDS ****************

  /*
  newScanRaw(ScanModel newScan) async {
    final db = await database;
    final result = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES (${newScan.id}, '${newScan.type}', '${newScan.value}')"
    );
    return result;
  }
  */

  newScan(ScanModel newScan) async {
    final db = await database;

    final result  = await db.insert('Scans', newScan.toJson());

    return result;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;

    final result = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return result.isNotEmpty ? ScanModel.fromJson(result.first) : null; 
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final result = await db.query('Scans');

    List<ScanModel> list = result.isNotEmpty ? result.map((scan) => ScanModel.fromJson(scan)).toList() : [];

    return list;
  }

  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;

    //final result = await db.query('Scans', where: 'type = ?', whereArgs: [type]);
    final result = await db.rawQuery("SELECT * FROM Scans WHERE type = '$type'");

    List<ScanModel> list = result.isNotEmpty ? result.map((scan) => ScanModel.fromJson(scan)).toList() : [];

    return list;
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final result = await db.update('Scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return result;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final result = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    final result = await db.rawDelete('DELETE FROM Scans');
    return result;
  }
}