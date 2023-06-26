class ALuser {
  String? id;
  bool isAdmin;
  String? username;
  String? email;
  String? pwd;
  String? date;
  int? coins;

  ALuser({
    this.id,
    this.isAdmin = false,
    this.username,
    this.email,
    this.pwd,
    this.date,
    this.coins,
  });

  factory ALuser.fromJson(Map<String, dynamic> json) {
    return ALuser(
      id: json['id'],
      isAdmin: json['isAdmin'],
      username: json['username'],
      email: json['email'],
      pwd: json['pwd'],
      date: json['date'],
      coins: json['coins'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isAdmin': isAdmin,
      'username': username,
      'email': email,
      'pwd': pwd,
      'date': date,
      'coins': coins,
    };
  }
}