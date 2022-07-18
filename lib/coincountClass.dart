class dataCoinCount {
  final String username;
  final String name;
  final String coincount;

  dataCoinCount(
      {required this.username, required this.name, required this.coincount});

  Map<String, dynamic> toJson() {
    return {"username": username, "symnamebol": name, "coincount": coincount};
  }

  factory dataCoinCount.fromJson(Map<String, dynamic> json) {
    return dataCoinCount(
        username: json['username'],
        name: json['name'],
        coincount: json['coincount']);
  }
}
