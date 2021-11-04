import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String RECIPES_QUERY =
    "CREATE TABLE recipes ("
      "_id TEXT PRIMARY KEY,"
      "name TEXT NOT NULL,"
      "publisher TEXT NOT NULL,"
      "photo TEXT,"
      "ratings INTEGER,"
      "average_rating REAL"
    ");";

const String USERS_QUERY =
    "CREATE TABLE users ("
      "username TEXT PRIMARY KEY,"
      "email TEXT UNIQUE NOT NULL,"
      "password TEXT NOT NULL"
    ");";

Future<Database> configureDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), "databases.db"),
    onCreate: (db, version) async {
      await db.execute(RECIPES_QUERY);
      await db.execute(USERS_QUERY);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
