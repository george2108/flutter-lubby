// ignore: todo
// TODO: AGREGAR favorite, color, totalItems - cantidad de detalles

import 'dart:ui';

class ToDoModel {
  int? id;
  String title;
  String? description;
  int complete;
  DateTime? createdAt;
  int percentCompleted;
  int totalItems;
  int favorite;
  Color color;

  ToDoModel({
    this.id,
    required this.title,
    this.description,
    required this.complete,
    this.createdAt,
    required this.percentCompleted,
    required this.totalItems,
    required this.favorite,
    required this.color,
  });

  ToDoModel copyWith({
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
      ToDoModel(
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
      "id": this.id,
      "title": this.title,
      "complete": this.complete,
      "description": this.description,
      "createdAt": this.createdAt.toString(),
      "percentCompleted": this.percentCompleted,
      "totalItems": this.totalItems,
      "favorite": this.favorite,
      "color": this.colorToString(),
    });
  }

  String colorToString() {
    return this.color.value.toRadixString(16);
  }

  factory ToDoModel.fromMap(Map<String, dynamic> json) => ToDoModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        complete: json["complete"],
        createdAt: DateTime.parse(json["createdAt"]),
        percentCompleted: json["percentCompleted"],
        totalItems: json["totalItems"],
        favorite: json["favorite"],
        color: Color(int.parse('0xFF' + json["color"])),
      );

  @override
  String toString() {
    return '''
      id: ${this.id},
      title: ${this.title},
      description: ${this.description},
      complete: ${this.complete},
      createdAt: ${this.createdAt},
      percentCompleted: ${this.percentCompleted},
      totalItems: ${this.totalItems},
      favorite: ${this.favorite},
      color: ${this.color},
    ''';
  }
}

///
/// Detalle de las tareas
///

class ToDoDetailModel {
  int? id;
  int? toDoId;
  String description;
  int complete;
  int orderDetail;

  ToDoDetailModel({
    this.id,
    this.toDoId,
    required this.description,
    required this.complete,
    required this.orderDetail,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "toDoId": this.toDoId,
      "description": this.description,
      "complete": this.complete,
      "orderDetail": this.orderDetail
    });
  }

  factory ToDoDetailModel.fromMap(Map<String, dynamic> json) => ToDoDetailModel(
        id: json["id"],
        toDoId: json["toDoId"],
        description: json["description"],
        complete: json["complete"],
        orderDetail: json["orderDetail"],
      );

  ToDoDetailModel copyWith({
    int? complete,
    String? description,
    int? todoId,
    int? orderDetail,
  }) =>
      ToDoDetailModel(
        id: this.id,
        toDoId: todoId ?? this.toDoId,
        description: description ?? this.description,
        complete: complete ?? this.complete,
        orderDetail: orderDetail ?? this.orderDetail,
      );

  @override
  String toString() {
    return '''
      id: ${this.id},
      toDoId: ${this.toDoId},
      description: ${this.description},
      complete: ${this.complete},
      orderDetail: ${this.orderDetail},
    ''';
  }
}
