// ignore: todo
// TODO: AGREGAR favorite, color, totalItems - cantidad de detalles

import 'dart:ui';

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
    int? complete,
    DateTime? createdAt,
    int? percentCompleted,
    int? totalItems,
    int? favorite,
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
      "complete": complete,
      "description": description,
      "createdAt": createdAt.toString(),
      "percentCompleted": percentCompleted,
      "totalItems": totalItems,
      "favorite": favorite,
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
        complete: json["complete"],
        createdAt: DateTime.parse(json["createdAt"]),
        percentCompleted: json["percentCompleted"],
        totalItems: json["totalItems"],
        favorite: json["favorite"],
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

///
/// Detalle de las tareas
///

class ToDoDetailEntity extends ToDoDetailAbstractEntity {
  const ToDoDetailEntity({
    id,
    toDoId,
    required description,
    required complete,
    required orderDetail,
  }) : super(
          id: id,
          toDoId: toDoId,
          description: description,
          complete: complete,
          orderDetail: orderDetail,
        );

  Map<String, dynamic> toMap() {
    return ({
      "id": id,
      "toDoId": toDoId,
      "description": description,
      "complete": complete,
      "orderDetail": orderDetail
    });
  }

  factory ToDoDetailEntity.fromMap(Map<String, dynamic> json) =>
      ToDoDetailEntity(
        id: json["id"],
        toDoId: json["toDoId"],
        description: json["description"],
        complete: json["complete"],
        orderDetail: json["orderDetail"],
      );

  ToDoDetailEntity copyWith({
    int? id,
    int? complete,
    String? description,
    int? todoId,
    int? orderDetail,
  }) =>
      ToDoDetailEntity(
        id: id ?? this.id,
        toDoId: todoId ?? toDoId,
        description: description ?? this.description,
        complete: complete ?? this.complete,
        orderDetail: orderDetail ?? this.orderDetail,
      );

  @override
  String toString() {
    return '''
      id: $id,
      toDoId: $toDoId,
      description: $description,
      complete: $complete,
      orderDetail: $orderDetail,
    ''';
  }
}
