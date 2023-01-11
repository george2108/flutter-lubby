import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/domain/entities/label_abstract_entity.dart';

class LabelEntity extends LabelAbstractEntity {
  const LabelEntity({
    super.id,
    required super.name,
    required super.icon,
    required super.color,
    required super.type,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "icon": icon.codePoint,
      "color": colorToString(),
      "type": type,
    };
  }

  factory LabelEntity.fromMap(Map<String, dynamic> json) => LabelEntity(
        id: json["id"],
        name: json["name"],
        icon: IconData(int.parse(json["icon"]), fontFamily: 'MaterialIcons'),
        color: Color(int.parse('0xFF${json["color"]}')),
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

  String colorToString() {
    return color.value.toRadixString(16);
  }
}
