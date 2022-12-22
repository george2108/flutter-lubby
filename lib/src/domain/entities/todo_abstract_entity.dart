import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class ToDoAbstractEntity extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final int complete;
  final DateTime? createdAt;
  final int percentCompleted;
  final int totalItems;
  final int favorite;
  final Color color;

  const ToDoAbstractEntity({
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

  @override
  bool? get stringify => true;
}

abstract class ToDoDetailAbstractEntity extends Equatable {
  final int? id;
  final int? toDoId;
  final String description;
  final int complete;
  final int orderDetail;

  const ToDoDetailAbstractEntity({
    this.id,
    this.toDoId,
    required this.description,
    required this.complete,
    required this.orderDetail,
  });

  @override
  List<Object?> get props => [
        id,
        toDoId,
        description,
        complete,
        orderDetail,
      ];

  @override
  bool? get stringify => true;
}
