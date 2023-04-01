import 'package:flutter/material.dart';
import 'package:lubby_app/src/domain/entities/todo_abstract_entity.dart';

class ToDoEntity extends ToDoAbstractEntity {
  const ToDoEntity({
    id,
    required title,
    description,
    required complete,
    createdAt,
    required percentCompleted,
    required totalItems,
    required favorite,
    required color,
  }) : super(
          id: id,
          title: title,
          description: description,
          complete: complete,
          createdAt: createdAt,
          percentCompleted: percentCompleted,
          totalItems: totalItems,
          favorite: favorite,
          color: color,
        );

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
}

////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
/// Detalle de las tareas por hacer                                          ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
class ToDoDetailEntity extends ToDoDetailAbstractEntity {
  const ToDoDetailEntity({
    id,
    toDoId,
    startDate,
    startTime,
    description,
    required title,
    required complete,
    required orderDetail,
  }) : super(
          id: id,
          toDoId: toDoId,
          title: title,
          description: description,
          complete: complete,
          orderDetail: orderDetail,
          startDate: startDate,
          startTime: startTime,
        );

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
}

////////////////////////////////////////////////////////////////////////////////
///                                                                          ///
/// Estado del detalle de las tareas por hacer                               ///
///                                                                          ///
////////////////////////////////////////////////////////////////////////////////
class ToDoDetailStatusEntity extends ToDoDetailStateAbstractEntity {
  const ToDoDetailStatusEntity({
    id,
    toDoDetailId,
    dateAffected,
    timeAffected,
    required complete,
  }) : super(
          id: id,
          toDoDetailId: toDoDetailId,
          dateAffected: dateAffected,
          timeAffected: timeAffected,
          complete: complete,
        );

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
    int? complete,
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
}
