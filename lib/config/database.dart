import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String USERS_QUERY =
    "CREATE TABLE users ("
    "username TEXT PRIMARY KEY,"
    "email TEXT UNIQUE NOT NULL,"
    "password TEXT NOT NULL"
    ");";

const String INGREDIENTS_QUERY =
    "CREATE TABLE ingredients ("
    "name TEXT PRIMARY KEY"
    ");";

const String USED_INGREDIENTS_QUERY =
    "CREATE TABLE used_ingredients ("
    "ingredient TEXT NOT NULL,"
    "amount REAL NOT NULL,"
    "measurement_unit TEXT NOT NULL,"
    "FOREIGN KEY (ingredient) REFERENCES ingredients(name)"
    ");";

const String OWNED_INGREDIENTS_QUERY =
    "CREATE TABLE owned_ingredients ("
    "ingredient TEXT NOT NULL,"
    "amount REAL NOT NULL,"
    "measurement_unit TEXT NOT NULL,"
    "owner TEXT NOT NULL,"
    "FOREIGN KEY (ingredient) REFERENCES ingredients(name),"
    "FOREIGN KEY (owner) REFERENCES users(username)"
    ");";

const String RECIPES_QUERY =
    "CREATE TABLE recipes ("
      "_id TEXT PRIMARY KEY,"
      "name TEXT NOT NULL,"
      "publisher TEXT NOT NULL,"
      "photo TEXT,"
      "ratings INTEGER,"
      "average_rating REAL,"
      "FOREIGN KEY (publisher) REFERENCES users(username)"
    ");";

Future<Database> configureDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), "databases.db"),
    onCreate: (db, version) async {
      await db.execute(USERS_QUERY);
      await db.execute(INGREDIENTS_QUERY);
      await db.execute(USED_INGREDIENTS_QUERY);
      await db.execute(OWNED_INGREDIENTS_QUERY);
      await db.execute(RECIPES_QUERY);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
