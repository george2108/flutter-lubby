import 'dart:ui';

class NoteModel {
  int? id;
  String title;
  String body;
  DateTime createdAt;
  int favorite;
  Color color;

  NoteModel({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.favorite,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "body": body,
      "createdAt": createdAt.toString(),
      "favorite": favorite,
      "color": colorToString(),
    });
  }

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        favorite: json["favorite"],
        color: Color(int.parse('0xFF${json["color"]}')),
      );

  String colorToString() {
    return color.value.toRadixString(16);
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    int? favorite,
    Color? color,
  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        favorite: favorite ?? this.favorite,
        color: color ?? this.color,
      );

  @override
  String toString() => '''
    id: $id, 
    title: $title,
    body: $body,
    createdAt: $createdAt,
    favorite: $favorite,
    color: $color,
    ''';
}
