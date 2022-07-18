class dataHistory {
  final String username;
  final String name;
  final String count;
  final String date;

  dataHistory(
      {required this.username,
      required this.name,
      required this.count,
      required this.date});

  Map<String, dynamic> toJson() {
    return {"username": username, "name": name, "count": count, "date": date};
  }

  factory dataHistory.fromJson(Map<String, dynamic> json) {
    return dataHistory(
        username: json['username'],
        name: json['name'],
        count: json['count'],
        date: json['date']);
  }
}
