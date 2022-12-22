import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class ActivityAbstractEntity extends Equatable {
  final int? id;
  final String title;
  final DateTime? createdAt;
  final bool favorite;

  const ActivityAbstractEntity({
    this.id,
    required this.title,
    required this.favorite,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        createdAt,
        favorite,
      ];
}

abstract class ActivityCardAbstractEntity extends Equatable {
  final int? id;
  final int? acitvityListId;
  final String title;
  final Color color;
  final String description;
  final DateTime? createdAt;
  final DateTime? dateLimit;
  final int orderDetail;

  const ActivityCardAbstractEntity({
    required this.title,
    required this.color,
    required this.description,
    required this.orderDetail,
    this.id,
    this.acitvityListId,
    this.createdAt,
    this.dateLimit,
  });

  @override
  List<Object?> get props => [
        id,
        acitvityListId,
        title,
        color,
        description,
        createdAt,
        dateLimit,
        orderDetail,
      ];

  @override
  bool? get stringify => true;
}

abstract class ActivityListAbstractEntity extends Equatable {
  final int? id;
  final int? activityId;
  final String title;
  final DateTime? createdAt;
  final int orderDetail;
  final List<ActivityCardAbstractEntity>? cards;

  const ActivityListAbstractEntity({
    required this.title,
    required this.orderDetail,
    this.activityId,
    this.createdAt,
    this.id,
    this.cards,
  });

  @override
  List<Object?> get props => [
        id,
        activityId,
        title,
        createdAt,
        orderDetail,
        cards,
      ];

  @override
  bool? get stringify => true;
}
