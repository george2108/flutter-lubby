import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  final String title;
  final String? description;
  final int complete;
  final int orderDetail;
  final DateTime? startDate;
  final TimeOfDay? startTime;

  const ToDoDetailAbstractEntity({
    required this.title,
    this.id,
    this.toDoId,
    this.startDate,
    this.startTime,
    this.description,
    required this.complete,
    required this.orderDetail,
  });

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

  @override
  bool? get stringify => true;
}

abstract class ToDoDetailStateAbstractEntity extends Equatable {
  final int? id;
  final int? toDoDetailId;
  final DateTime? dateAffected;
  final TimeOfDay? timeAffected;
  final int complete;

  const ToDoDetailStateAbstractEntity({
    this.id,
    this.toDoDetailId,
    this.dateAffected,
    this.timeAffected,
    required this.complete,
  });

  @override
  List<Object?> get props => [
        id,
        toDoDetailId,
        complete,
        dateAffected,
        timeAffected,
      ];

  @override
  bool? get stringify => true;
}
