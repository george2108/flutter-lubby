import 'dart:ui';

import 'package:lubby_app/src/data/datasources/local/services/password_service.dart';
import 'package:lubby_app/src/domain/entities/password_abstract_entity.dart';

class PasswordEntity extends PasswordAbstractEntity {
  const PasswordEntity({
    required super.title,
    required super.password,
    required super.favorite,
    required super.color,
    super.id,
    super.user,
    super.description,
    super.createdAt,
    super.url,
    super.notas,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "password": PasswordService().encrypt(password),
      "favorite": favorite ? 1 : 0,
      "user": user,
      "description": description,
      "createdAt": createdAt.toString(),
      "url": url.toString(),
      "notas": notas.toString(),
      "color": color.value,
    };
  }

  factory PasswordEntity.fromMap(Map<String, dynamic> json) => PasswordEntity(
        id: json["id"],
        title: json["title"],
        password: PasswordService().decrypt(json["password"]),
        favorite: json["favorite"] == 1,
        user: json["user"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        url: json["url"],
        notas: json["notas"],
        color: Color(json["color"]),
      );

  PasswordEntity copyWith({
    int? id,
    String? password,
    String? title,
    bool? favorite,
    String? user,
    String? description,
    DateTime? createdAt,
    String? url,
    String? notas,
    Color? color,
  }) =>
      PasswordEntity(
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
  List<Object?> get props => [
        id,
        password,
        title,
        favorite,
        user,
        description,
        createdAt,
        url,
        notas,
        color,
      ];

  @override
  bool? get stringify => true;

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
