
class User {
  int? id;
  bool isAdmin;
  String? username;
  String? email;
  String? password;
  String? date;

  User({
    required this.id,
    required this.isAdmin,
    required this.username,
    required this.email,
    required this.password,
    required this.date,
  });
}