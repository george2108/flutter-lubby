import 'dart:ui';

import 'package:lubby_app/src/domain/entities/activity_abstract_entity.dart';

class ActivityCardEntity extends ActivityCardAbstractEntity {
  const ActivityCardEntity({
    id,
    acitvityListId,
    required title,
    required color,
    required description,
    required orderDetail,
    createdAt,
    dateLimit,
  }) : super(
          id: id,
          acitvityListId: acitvityListId,
          title: title,
          color: color,
          description: description,
          orderDetail: orderDetail,
          createdAt: createdAt,
          dateLimit: dateLimit,
        );

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "acitvityListId": acitvityListId,
      "title": title,
      "color": colorToString(),
      "description": description,
      "createdAt": createdAt.toString(),
      "dateLimit": dateLimit.toString(),
      "orderDetail": orderDetail,
    });
  }

  String colorToString() {
    return color.value.toRadixString(16);
  }

  factory ActivityCardEntity.fromMap(Map<String, dynamic> json) =>
      ActivityCardEntity(
        id: json["id"],
        acitvityListId: json["acitvityListId"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        dateLimit: DateTime.parse(json["dateLimit"]),
        color: Color(int.parse('0xFF${json["color"]}')),
        description: json["description"],
        orderDetail: json["orderDetail"],
      );

  ActivityCardEntity copyWith({
    String? title,
    DateTime? createdAt,
    DateTime? dateLimit,
    bool? favorite,
    Color? color,
    String? description,
    int? orderDetail,
  }) =>
      ActivityCardEntity(
        id: id,
        acitvityListId: acitvityListId,
        title: title ?? this.title,
        color: color ?? this.color,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        dateLimit: dateLimit ?? this.dateLimit,
        orderDetail: orderDetail ?? this.orderDetail,
      );
}
