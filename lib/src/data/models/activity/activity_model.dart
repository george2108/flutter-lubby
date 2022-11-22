import 'package:lubby_app/src/domain/entities/activity_entity.dart';

class ActivityModel extends Activity {
  const ActivityModel({
    id,
    required title,
    required favorite,
    createdAt,
  }) : super(
          id: id,
          title: title,
          favorite: favorite,
          createdAt: createdAt,
        );

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "createdAt": createdAt.toString(),
      "favorite": favorite ? 1 : 0,
    });
  }

  factory ActivityModel.fromMap(Map<String, dynamic> json) => ActivityModel(
        id: json["id"],
        title: json["title"],
        favorite: json["favorite"] == 1,
        createdAt: DateTime.parse(json["createdAt"]),
      );

  ActivityModel copyWith({
    String? title,
    DateTime? createdAt,
    bool? favorite,
  }) =>
      ActivityModel(
        title: title ?? this.title,
        favorite: favorite ?? this.favorite,
        createdAt: createdAt ?? this.createdAt,
        id: id,
      );
}
