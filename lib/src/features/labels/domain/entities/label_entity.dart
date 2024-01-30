import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class LabelEntity extends Equatable {
  final int? appId;
  final int? id;
  final String name;
  final IconData icon;
  final Color color;
  final String type;
  final DateTime createdAt;

  const LabelEntity({
    this.appId,
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "appId": appId,
      "id": id,
      "name": name,
      "icon": icon.codePoint,
      "color": color.value,
      "type": type,
      "createdAt": createdAt.toString().replaceAll(' ', 'T'),
    };
  }

  factory LabelEntity.fromMap(Map<String, dynamic> json) => LabelEntity(
        appId: json["appId"],
        id: json["id"],
        name: json["name"],
        icon: IconData(int.parse(json["icon"]), fontFamily: 'MaterialIcons'),
        color: Color(json["color"]),
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"].toString()),
      );

  LabelEntity copyWith({
    int? appId,
    int? id,
    String? name,
    IconData? icon,
    Color? color,
    String? type,
    DateTime? createdAt,
  }) =>
      LabelEntity(
        appId: appId ?? this.appId,
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        type: type ?? this.type,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => [
        appId,
        id,
        name,
        icon,
        color,
        type,
        createdAt,
      ];

  @override
  bool get stringify => true;
}
