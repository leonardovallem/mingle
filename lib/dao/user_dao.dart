import 'package:projects/config/authentication.dart';
import 'package:projects/config/database.dart';
import 'package:projects/model/user.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createUserAndAuthenticate(User user) async {
  final db = await configureDatabase();
  user = encryptedUser(user);

  await db.insert(
    "users",
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  authenticate();
  db.close();
}

Future<User?> findUser(String email) async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query(
    "users",
    where: "email = ?",
    whereArgs: [email],
  );

  db.close();

  List<User> usersFound = List.generate(maps.length, (index) => User.fromMap(maps[index]));
  return usersFound.isEmpty ? null : usersFound.first;
}

Future<String?> currentUsername() async {
  var email = await currentUser();
  if(email == null) return null;

  return (await findUser(email))!.username;
}

Future<bool> findUserAndAuthenticate(User user) async {
  User? foundUser = await findUser(user.email);
  if (foundUser == null) return false;

  bool correctPassword = matchPasswords(user, foundUser.password);

  if (!correctPassword) return false;

  authenticate();
  return true;
}

Future<List<User>> savedUsers() async {
  final db = await configureDatabase();

  final List<Map<String, dynamic>> maps = await db.query("users");

  db.close();
  return List.generate(maps.length, (index) => User.fromMap(maps[index]));
}
