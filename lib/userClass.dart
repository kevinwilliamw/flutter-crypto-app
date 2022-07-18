class dataUser {
  final String username;
  final String password;

  dataUser({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {"username": username, "password": password};
  }

  factory dataUser.fromJson(Map<String, dynamic> json) {
    return dataUser(username: json['username'], password: json['password']);
  }
}
