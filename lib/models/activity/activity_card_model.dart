import 'dart:ui';

class ActivityCardModel {
  int? id;
  int? acitvityListId;
  String title;
  Color color;
  String description;
  DateTime? createdAt;
  DateTime? dateLimit;
  int orderDetail;

  ActivityCardModel({
    this.id,
    this.acitvityListId,
    required this.title,
    required this.color,
    required this.description,
    required this.orderDetail,
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

  factory ActivityCardModel.fromMap(Map<String, dynamic> json) =>
      ActivityCardModel(
        id: json["id"],
        acitvityListId: json["acitvityListId"],
        title: json["title"],
        createdAt: DateTime.parse(json["createdAt"]),
        dateLimit: DateTime.parse(json["dateLimit"]),
        color: Color(int.parse('0xFF${json["color"]}')),
        description: json["description"],
        orderDetail: json["orderDetail"],
      );

  ActivityCardModel copyWith({
    String? title,
    DateTime? createdAt,
    DateTime? dateLimit,
    bool? favorite,
    Color? color,
    String? description,
    int? orderDetail,
  }) =>
      ActivityCardModel(
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
