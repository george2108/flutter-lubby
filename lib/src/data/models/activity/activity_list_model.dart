import 'package:lubby_app/src/domain/entities/activity_entity.dart';

class ActivityListModel extends ActivityList {
  const ActivityListModel({
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

  factory ActivityListModel.fromMap(Map<String, dynamic> json) =>
      ActivityListModel(
        id: json["id"],
        activityId: json["activityId"],
        orderDetail: json["orderDetail"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  ActivityListModel copyWith({
    String? title,
    DateTime? createdAt,
    int? orderDetail,
  }) =>
      ActivityListModel(
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id,
        activityId: activityId,
        orderDetail: orderDetail ?? this.orderDetail,
      );
}
