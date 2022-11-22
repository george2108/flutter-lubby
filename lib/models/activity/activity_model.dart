class ActivityModel {
  int? id;
  String title;
  DateTime? createdAt;
  bool favorite;

  ActivityModel({
    this.id,
    required this.title,
    required this.favorite,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "createdAt": createdAt.toString(),
      "favorite": favorite ? 1 : 0,
    });
  }

  factory ActivityModel.fromMap(Map<String, dynamic> json) => ActivityModel(
        id: json["id"],
        title: json["title"],
        favorite: json["favorite"] == 1,
        createdAt: DateTime.parse(json["createdAt"]),
      );

  ActivityModel copyWith({
    String? title,
    DateTime? createdAt,
    bool? favorite,
  }) =>
      ActivityModel(
        title: title ?? this.title,
        favorite: favorite ?? this.favorite,
        createdAt: createdAt ?? this.createdAt,
        id: id,
      );
}
