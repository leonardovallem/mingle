import 'package:crypt/crypt.dart';
import 'package:projects/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

User encryptedUser(User user) {
  String hash = Crypt.sha256(user.password).toString();
  user.password = hash;
  return user;
}

bool matchPasswords(User user, String hash) {
  return Crypt(hash).match(user.password);
}

void authenticate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("authenticated", true);
}

void signOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("authenticated", false);
}

Future<void> saveUser(String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("user", email);
}

Future<String?> currentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("user");
}

Future<bool> isAuthenticated() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? auth = prefs.getBool("authenticated");
  return auth ?? false;
}
