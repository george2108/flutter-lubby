import 'package:lubby_app/src/domain/entities/activity_abstract_entity.dart';

class ActivityEntity extends ActivityAbstractEntity {
  const ActivityEntity({
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

  factory ActivityEntity.fromMap(Map<String, dynamic> json) => ActivityEntity(
        id: json["id"],
        title: json["title"],
        favorite: json["favorite"] == 1,
        createdAt: DateTime.parse(json["createdAt"]),
      );

  ActivityEntity copyWith({
    String? title,
    DateTime? createdAt,
    bool? favorite,
  }) =>
      ActivityEntity(
        title: title ?? this.title,
        favorite: favorite ?? this.favorite,
        createdAt: createdAt ?? this.createdAt,
        id: id,
      );
}
