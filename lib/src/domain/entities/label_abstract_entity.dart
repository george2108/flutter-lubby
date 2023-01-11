import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

abstract class LabelAbstractEntity extends Equatable {
  final int? id;
  final String name;
  final IconData icon;
  final Color color;
  final String type;

  const LabelAbstractEntity({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        icon,
        color,
        type,
      ];

  @override
  bool get stringify => true;
}
