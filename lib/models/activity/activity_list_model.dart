import 'package:lubby_app/models/activity/activity_card_model.dart';

class ActivityListModel {
  int? id;
  int? activityId;
  String title;
  DateTime? createdAt;
  int orderDetail;
  List<ActivityCardModel>? cards;

  ActivityListModel({
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
