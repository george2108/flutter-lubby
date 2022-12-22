import 'package:lubby_app/src/domain/entities/activity_abstract_entity.dart';

class ActivityListEntity extends ActivityListAbstractEntity {
  const ActivityListEntity({
    required title,
    required orderDetail,
    activityId,
    createdAt,
    id,
    cards,
  }) : super(
          title: title,
          orderDetail: orderDetail,
          activityId: activityId,
          createdAt: createdAt,
          id: id,
          cards: cards,
        );

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
}
