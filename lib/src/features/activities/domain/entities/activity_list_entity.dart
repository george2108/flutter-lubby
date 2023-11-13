import 'package:equatable/equatable.dart';

import 'activity_card_entity.dart';

class ActivityListEntity extends Equatable {
  final int? id;
  final int? activityId;
  final String title;
  final DateTime? createdAt;
  final int orderDetail;
  final List<ActivityCardEntity>? cards;

  const ActivityListEntity({
    required this.title,
    required this.orderDetail,
    this.activityId,
    this.createdAt,
    this.id,
    this.cards,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "activityId": activityId,
      "title": title,
      "orderDetail": orderDetail,
      "createdAt": createdAt.toString(),
    });
  }

  factory ActivityListEntity.fromMap(Map<String, dynamic> json) =>
      ActivityListEntity(
        id: json["id"],
        activityId: json["activityId"],
        orderDetail: json["orderDetail"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  ActivityListEntity copyWith({
    String? title,
    DateTime? createdAt,
    int? orderDetail,
  }) =>
      ActivityListEntity(
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id,
        activityId: activityId,
        orderDetail: orderDetail ?? this.orderDetail,
      );

  @override
  List<Object?> get props => [
        id,
        activityId,
        title,
        createdAt,
        orderDetail,
      ];
}
