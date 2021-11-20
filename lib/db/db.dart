import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

late final Future<Database> database;

Future<void> initDatabase() async => database = openDatabase(
    path.join(await getDatabasesPath(), 'mythic.db'),
    onCreate: (db, version) => db.batch()
      ..execute(
          'CREATE TABLE `CHARACTER`(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `detail` TEXT)')
      ..execute(
          'CREATE TABLE `LOCATION`(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `detail` TEXT)')
      ..execute(
          'CREATE TABLE `SCENE`(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `detail` TEXT)')
      ..execute(
          'CREATE TABLE `THREAD`(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `detail` TEXT)')
      ..commit(),
    version: 1);
