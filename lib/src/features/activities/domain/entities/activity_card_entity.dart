import 'dart:ui';

import 'package:equatable/equatable.dart';

class ActivityCardEntity extends Equatable {
  final int? id;
  final int? acitvityListId;
  final String title;
  final Color color;
  final String description;
  final DateTime? createdAt;
  final DateTime? dateLimit;
  final int orderDetail;

  const ActivityCardEntity({
    required this.title,
    required this.color,
    required this.description,
    required this.orderDetail,
    this.id,
    this.acitvityListId,
    this.createdAt,
    this.dateLimit,
  });

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

  @override
  List<Object?> get props => [
        id,
        acitvityListId,
        title,
        color,
        description,
        createdAt,
        dateLimit,
        orderDetail,
      ];
}
