import 'dart:ui';

import 'package:lubby_app/src/domain/entities/note_abstract_entity.dart';

class NoteEntity extends NoteAbstractEntity {
  const NoteEntity({
    id,
    required title,
    required body,
    required createdAt,
    required favorite,
    required color,
  }) : super(
          id: id,
          title: title,
          body: body,
          createdAt: createdAt,
          favorite: favorite,
          color: color,
        );

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "createdAt": createdAt.toString(),
      "favorite": favorite,
      "color": colorToString(),
    };
  }

  factory NoteEntity.fromMap(Map<String, dynamic> json) => NoteEntity(
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

  NoteEntity copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    int? favorite,
    Color? color,
  }) =>
      NoteEntity(
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
