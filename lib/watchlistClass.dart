class dataWatchList {
  final String username;
  final String name;

  dataWatchList({required this.username, required this.name});

  Map<String, dynamic> toJson() {
    return {"username": username, "name": name};
  }

  factory dataWatchList.fromJson(Map<String, dynamic> json) {
    return dataWatchList(username: json['username'], name: json['name']);
  }
}
