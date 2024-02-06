import 'dart:ui';

import 'package:equatable/equatable.dart';

import '../../../core/constants/constants.dart';
import '../../labels/domain/entities/label_entity.dart';

class NoteEntity extends Equatable {
  final int? appId;
  final int? id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool favorite;
  final Color color;
  final LabelEntity? label;
  final int? labelId;

  const NoteEntity({
    this.appId,
    this.id,
    this.label,
    this.labelId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.favorite,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      "appId": appId,
      "id": id,
      "title": title,
      "body": body,
      "createdAt": createdAt.toString(),
      "favorite": favorite ? 1 : 0,
      "color": color.value,
      "labelId": labelId,
    };
  }

  factory NoteEntity.fromMap(Map<String, dynamic> json) => NoteEntity(
        appId: json["appId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        favorite: json["favorite"] == 1,
        color: Color(json["color"]),
        labelId: json["labelId"],
        label:
            json["label"] != null ? LabelEntity.fromMap(json["label"]) : null,
      );

  factory NoteEntity.empty() => NoteEntity(
        title: '',
        body: '',
        createdAt: DateTime.now(),
        favorite: false,
        color: kDefaultColorPick,
      );

  NoteEntity copyWith({
    int? appId,
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? favorite,
    Color? color,
    LabelEntity? label,
    int? labelId,
  }) =>
      NoteEntity(
        appId: appId ?? this.appId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        favorite: favorite ?? this.favorite,
        color: color ?? this.color,
        label: label ?? this.label,
        labelId: labelId ?? this.labelId,
      );

  @override
  List<Object?> get props => [
        appId,
        id,
        title,
        body,
        createdAt,
        favorite,
        color,
        label,
        labelId,
      ];

  @override
  String toString() => '''
    appId: $appId,
    id: $id, 
    title: $title,
    body: $body,
    createdAt: $createdAt,
    favorite: $favorite,
    color: $color,
    label: $label,
    labelId: $labelId,
    ''';
}
