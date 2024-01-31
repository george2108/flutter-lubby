import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../data/datasources/local/password_service.dart';
import '../../labels/domain/entities/label_entity.dart';

class PasswordEntity extends Equatable {
  final int? appId;
  final int? id;
  final String password;
  final String title;
  final bool favorite;
  final String? userName;
  final String? description;
  final DateTime? createdAt;
  final String? url;
  final String? notas;
  final Color color;
  final IconData icon;
  final int? labelId;
  final LabelEntity? label;

  const PasswordEntity({
    this.appId,
    this.id,
    required this.title,
    required this.password,
    required this.favorite,
    required this.color,
    required this.icon,
    this.labelId,
    this.label,
    this.userName,
    this.description,
    this.createdAt,
    this.url,
    this.notas,
  });

  Map<String, dynamic> toMap() {
    return {
      "appId": appId,
      "id": id,
      "title": title,
      "password": PasswordService().encrypt(password),
      "favorite": favorite ? 1 : 0,
      "userName": userName,
      "description": description,
      "createdAt": createdAt.toString().replaceAll(' ', 'T'),
      "url": url.toString(),
      "notas": notas.toString(),
      "color": color.value,
      "icon": icon.codePoint.toString(),
      "labelId": labelId,
    };
  }

  factory PasswordEntity.fromMap(Map<String, dynamic> json) => PasswordEntity(
        appId: json["appId"],
        id: json["id"],
        title: json["title"],
        password: PasswordService().decrypt(json["password"]),
        favorite: json["favorite"] == 1,
        userName: json["userName"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        url: json["url"],
        notas: json["notas"],
        color: Color(json["color"]),
        icon: IconData(int.parse(json["icon"]), fontFamily: 'MaterialIcons'),
        labelId: json["labelId"],
        label:
            json["label"] != null ? LabelEntity.fromMap(json["label"]) : null,
      );

  PasswordEntity copyWith({
    int? appId,
    int? id,
    String? password,
    String? title,
    bool? favorite,
    String? userName,
    String? description,
    DateTime? createdAt,
    String? url,
    String? notas,
    Color? color,
    LabelEntity? label,
    int? labelId,
    IconData? icon,
  }) =>
      PasswordEntity(
        appId: appId ?? this.appId,
        id: id ?? this.id,
        password: password ?? this.password,
        title: title ?? this.title,
        favorite: favorite ?? this.favorite,
        userName: userName ?? this.userName,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        url: url ?? this.url,
        notas: notas ?? this.notas,
        color: color ?? this.color,
        label: label ?? this.label,
        labelId: labelId ?? this.labelId,
        icon: icon ?? this.icon,
      );

  @override
  List<Object?> get props => [
        appId,
        id,
        password,
        title,
        favorite,
        userName,
        description,
        createdAt,
        url,
        notas,
        color,
        label,
        labelId,
        icon,
      ];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return '''
      appId: $appId,
      id: $id,
      title: $title,
      password: $password,
      favorite: $favorite,
      userName: $userName,
      description: $description,
      createdAt: $createdAt,
      url: $url,
      notas: $notas,
      color: $color,
      label: $label,
      labelId: $labelId,
      icon: $icon,
    ''';
  }
}
