import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ToDoEntity extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final bool complete;
  final DateTime? createdAt;
  final int percentCompleted;
  final int totalItems;
  final bool favorite;
  final Color color;

  const ToDoEntity({
    required this.title,
    required this.complete,
    required this.percentCompleted,
    required this.totalItems,
    required this.favorite,
    required this.color,
    this.id,
    this.description,
    this.createdAt,
  });

  ToDoEntity copyWith({
    int? id,
    String? title,
    String? description,
    bool? complete,
    DateTime? createdAt,
    int? percentCompleted,
    int? totalItems,
    bool? favorite,
    Color? color,
  }) =>
      ToDoEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        complete: complete ?? this.complete,
        createdAt: createdAt ?? this.createdAt,
        percentCompleted: percentCompleted ?? this.percentCompleted,
        totalItems: totalItems ?? this.totalItems,
        favorite: favorite ?? this.favorite,
        color: color ?? this.color,
      );

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "title": title,
      "complete": complete ? 1 : 0,
      "description": description,
      "createdAt": createdAt.toString(),
      "percentCompleted": percentCompleted,
      "totalItems": totalItems,
      "favorite": favorite ? 1 : 0,
      "color": colorToString(),
    });
  }

  String colorToString() {
    return color.value.toRadixString(16);
  }

  factory ToDoEntity.fromMap(Map<String, dynamic> json) => ToDoEntity(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        complete: json["complete"] == 1,
        createdAt: DateTime.parse(json["createdAt"]),
        percentCompleted: json["percentCompleted"],
        totalItems: json["totalItems"],
        favorite: json["favorite"] == 1,
        color: Color(int.parse('0xFF${json["color"]}')),
      );

  @override
  String toString() {
    return '''
      id: $id,
      title: $title,
      description: $description,
      complete: $complete,
      createdAt: $createdAt,
      percentCompleted: $percentCompleted,
      totalItems: $totalItems,
      favorite: $favorite,
      color: $color,
    ''';
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        complete,
        createdAt,
        percentCompleted,
        totalItems,
        favorite,
        color,
      ];
}

////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
/// Detalle de las tareas por hacer                                          ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
class ToDoDetailEntity extends Equatable {
  final int? id;
  final int? toDoId;
  final String title;
  final String? description;
  final bool complete;
  final int orderDetail;
  final DateTime? startDate;
  final TimeOfDay? startTime;

  const ToDoDetailEntity({
    required this.title,
    this.id,
    this.toDoId,
    this.startDate,
    this.startTime,
    this.description,
    required this.complete,
    required this.orderDetail,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "toDoId": toDoId,
      "title": title,
      "description": description,
      "complete": complete ? 1 : 0,
      "orderDetail": orderDetail,
      "startDate": startDate.toString(),
      "startTime": startTime.toString(),
    };
  }

  factory ToDoDetailEntity.fromMap(Map<String, dynamic> json) =>
      ToDoDetailEntity(
        id: json["id"],
        toDoId: json["toDoId"],
        title: json["title"],
        description: json["description"],
        complete: json["complete"] == 1,
        orderDetail: json["orderDetail"],
        startDate: DateTime.parse(json["startDate"]),
        startTime: TimeOfDay.fromDateTime(DateTime.parse(json["startTime"])),
      );

  ToDoDetailEntity copyWith({
    int? id,
    bool? complete,
    String? title,
    String? description,
    int? todoId,
    int? orderDetail,
    DateTime? startDate,
    TimeOfDay? startTime,
  }) =>
      ToDoDetailEntity(
        id: id ?? this.id,
        toDoId: todoId ?? toDoId,
        title: title ?? this.title,
        description: description ?? this.description,
        complete: complete ?? this.complete,
        orderDetail: orderDetail ?? this.orderDetail,
        startDate: startDate ?? this.startDate,
        startTime: startTime ?? this.startTime,
      );

  @override
  String toString() {
    return '''
      id: $id,
      toDoId: $toDoId,
      title: $title,
      description: $description,
      complete: $complete,
      orderDetail: $orderDetail,
      startDate: $startDate,
      startTime: $startTime,
    ''';
  }

  @override
  List<Object?> get props => [
        id,
        toDoId,
        title,
        description,
        complete,
        orderDetail,
        startDate,
        startTime,
      ];
}

////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
/// Estado del detalle de las tareas por hacer                               ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
class ToDoDetailStatusEntity extends Equatable {
  final int? id;
  final int? toDoDetailId;
  final DateTime? dateAffected;
  final TimeOfDay? timeAffected;
  final bool complete;

  const ToDoDetailStatusEntity({
    this.id,
    this.toDoDetailId,
    this.dateAffected,
    this.timeAffected,
    required this.complete,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "toDoDetailId": toDoDetailId,
      "complete": complete,
      "dateAffected": dateAffected.toString(),
      "timeAffected": timeAffected.toString(),
    });
  }

  factory ToDoDetailStatusEntity.fromMap(Map<String, dynamic> json) =>
      ToDoDetailStatusEntity(
        id: json["id"],
        toDoDetailId: json["toDoDetailId"],
        complete: json["complete"],
        dateAffected: DateTime.parse(json["dateAffected"]),
        timeAffected:
            TimeOfDay.fromDateTime(DateTime.parse(json["timeAffected"])),
      );

  ToDoDetailStatusEntity copyWith({
    int? id,
    bool? complete,
    int? toDoDetailId,
    DateTime? dateAffected,
    TimeOfDay? timeAffected,
  }) =>
      ToDoDetailStatusEntity(
        id: id ?? this.id,
        toDoDetailId: toDoDetailId ?? this.toDoDetailId,
        complete: complete ?? this.complete,
        dateAffected: dateAffected ?? this.dateAffected,
        timeAffected: timeAffected ?? this.timeAffected,
      );

  @override
  String toString() {
    return '''
      id: $id,
      toDoDetailId: $toDoDetailId,
      complete: $complete,
      dateAffected: $dateAffected,
      timeAffected: $timeAffected,
    ''';
  }

  @override
  List<Object?> get props => [
        id,
        toDoDetailId,
        complete,
        dateAffected,
        timeAffected,
      ];
}
