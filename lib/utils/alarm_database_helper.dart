import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hisnelmoslem/models/alarm.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

AlarmDatabaseHelper alarmDatabaseHelper = AlarmDatabaseHelper();

class AlarmDatabaseHelper {
  /* ************* Variables ************* */

  static const String dbName = "alarms_database.db";
  static const int dbVersion = 1;

  static AlarmDatabaseHelper? _databaseHelper;
  static Database? _database;

  /* ************* Singelton Constractor ************* */

  AlarmDatabaseHelper._createInstance();

  factory AlarmDatabaseHelper() {
    _databaseHelper ??= AlarmDatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  /* ************* Database Creation ************* */

  // init
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    final exist = await databaseExists(path);

    //Check if database is already in that Directory
    if (!exist) {
      // Database isn't exist > Create new Database
      await _copyFromAssets(path: path);
    }

    return await openDatabase(
      path,
      version: dbVersion,
      onCreate: _onCreateDatabase,
      onUpgrade: _onUpgradeDatabase,
      onDowngrade: _onDowngradeDatabase,
    );
  }

  // On create database
  _onCreateDatabase(Database db, int version) async {
    //
  }

  // On upgrade database version
  _onUpgradeDatabase(Database db, int oldVersion, int newVersion) {
    //
  }

  // On downgrade database version
  _onDowngradeDatabase(Database db, int oldVersion, int newVersion) {
    //
  }

  // Copy database from assets to Database Direcorty of app
  _copyFromAssets({required String path}) async {
    //
    try {
      await Directory(dirname(path)).create(recursive: true);

      ByteData data = await rootBundle.load(join("assets", "db", dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /* ************* Functions ************* */

  // Get all alarms from database
  Future<List<DbAlarm>> getAlarms() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('alarms');

    return List.generate(maps.length, (i) {
      return DbAlarm.fromMap(maps[i]);
    });
  }

  // Add new alarm to database
  Future<void> addNewAlarm({required DbAlarm dbAlarm}) async {
    final db = await database;

    await db.insert(
      'alarms',
      dbAlarm.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update alarm by ID
  Future<void> updateAlarmInfo({required DbAlarm dbAlarm}) async {
    final db = await database;

    await db.update(
      'alarms',
      dbAlarm.toMap(),
      where: "id = ?",
      whereArgs: [dbAlarm.id],
    );
  }

  // Delete alarm by ID
  Future<void> deleteAlarm({required DbAlarm dbAlarm}) async {
    final db = await database;

    await db.delete(
      'alarms',
      where: "titleId = ?",
      whereArgs: [dbAlarm.titleId],
    );
  }

  // Close database
  Future close() async {
    final db = await database;
    db.close();
  }
}
