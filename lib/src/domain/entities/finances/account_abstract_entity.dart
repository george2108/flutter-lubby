import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';

abstract class AccountAbstractEntity extends Equatable {
  final int? id;
  final int? labelId;
  final LabelEntity? label;
  final String? description;
  final String name;
  final double balance;
  final DateTime createdAt;
  final IconData icon;
  final Color color;

  const AccountAbstractEntity({
    this.id,
    this.labelId,
    this.label,
    this.description,
    required this.name,
    required this.balance,
    required this.createdAt,
    required this.icon,
    required this.color,
  });

  @override
  List<Object?> get props => [
        id,
        labelId,
        label,
        name,
        description,
        balance,
        createdAt,
        icon,
        color,
      ];

  @override
  bool? get stringify => true;
}
