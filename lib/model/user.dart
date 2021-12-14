class User {
  String? username;
  String email;
  String password;

  User({this.username, required this.email, required this.password});

  Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "password": password,
      };

  static User fromMap(Map<String, dynamic> user) => User(
        username: user["username"],
        email: user["email"],
        password: user["password"],
      );

  bool equals(User user) {
    bool _noUserName = username == null || user.username == null;
    return (_noUserName || username == user.username) && email == user.email && password == user.password;
  }
}
