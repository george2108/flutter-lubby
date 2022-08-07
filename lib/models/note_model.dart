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
      "id": this.id,
      "title": this.title,
      "body": this.body,
      "createdAt": this.createdAt.toString(),
      "favorite": this.favorite,
      "color": this.colorToString(),
    });
  }

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        favorite: json["favorite"],
        color: Color(int.parse('0xFF' + json["color"])),
      );

  String colorToString() {
    return this.color.value.toRadixString(16);
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
    id: ${this.id} 
    title: ${this.title}
    body: ${this.body}
    createdAt: ${this.createdAt}
    favorite: ${this.favorite}
    color: ${this.color}
    ''';
}
