import 'dart:ui';

import 'package:lubby_app/src/domain/entities/password_entity.dart';

class PasswordModel extends Password {
  const PasswordModel({
    required title,
    required password,
    required favorite,
    required color,
    id,
    user,
    description,
    createdAt,
    url,
    notas,
  }) : super(
          title: title,
          password: password,
          favorite: favorite,
          color: color,
          id: id,
          user: user,
          description: description,
          createdAt: createdAt,
          url: url,
          notas: notas,
        );

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "password": password,
      "favorite": favorite,
      "user": user,
      "description": description,
      "createdAt": createdAt.toString(),
      "url": url.toString(),
      "notas": notas.toString(),
      "color": colorToString(),
    });
  }

  String colorToString() {
    return color.value.toRadixString(16);
  }

  factory PasswordModel.fromMap(Map<String, dynamic> json) => PasswordModel(
        id: json["id"],
        title: json["title"],
        password: json["password"],
        favorite: json["favorite"],
        user: json["user"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        url: json["url"],
        notas: json["notas"],
        color: Color(int.parse('0xFF${json["color"]}')),
      );

  PasswordModel copyWith({
    int? id,
    String? password,
    String? title,
    int? favorite,
    String? user,
    String? description,
    DateTime? createdAt,
    String? url,
    String? notas,
    Color? color,
  }) =>
      PasswordModel(
        id: id ?? this.id,
        password: password ?? this.password,
        title: title ?? this.title,
        favorite: favorite ?? this.favorite,
        user: user ?? this.user,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        url: url ?? this.url,
        notas: notas ?? this.notas,
        color: color ?? this.color,
      );

  @override
  String toString() {
    return '''
      id: $id,
      title: $title,
      password: $password,
      favorite: $favorite,
      user: $user,
      description: $description,
      createdAt: $createdAt,
      url: $url,
      notas: $notas,
      color: $color,
    ''';
  }
}
