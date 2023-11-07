import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class LabelEntity extends Equatable {
  final int? id;
  final String name;
  final IconData icon;
  final Color color;
  final String type;

  const LabelEntity({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "icon": icon.codePoint,
      "color": color.value,
      "type": type,
    };
  }

  factory LabelEntity.fromMap(Map<String, dynamic> json) => LabelEntity(
        id: json["id"],
        name: json["name"],
        icon: IconData(int.parse(json["icon"]), fontFamily: 'MaterialIcons'),
        color: Color(json["color"]),
        type: json["type"],
      );

  LabelEntity copyWith({
    int? id,
    String? name,
    IconData? icon,
    Color? color,
    String? type,
  }) =>
      LabelEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        type: type ?? this.type,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        color,
        type,
      ];

  @override
  bool get stringify => true;
}
