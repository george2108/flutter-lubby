import 'package:equatable/equatable.dart';

class ActivityEntity extends Equatable {
  final int? id;
  final String title;
  final DateTime? createdAt;
  final bool favorite;

  const ActivityEntity({
    this.id,
    required this.title,
    required this.favorite,
    this.createdAt,
  });

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

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        favorite,
      ];
}
