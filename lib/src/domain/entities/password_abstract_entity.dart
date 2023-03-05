import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';

abstract class PasswordAbstractEntity extends Equatable {
  final int? id;
  final String password;
  final String title;
  final bool favorite;
  final String? user;
  final String? description;
  final DateTime? createdAt;
  final String? url;
  final String? notas;
  final Color color;
  final IconData icon;
  final int? labelId;
  final LabelEntity? label;

  const PasswordAbstractEntity({
    required this.title,
    required this.password,
    required this.favorite,
    required this.color,
    required this.icon,
    this.labelId,
    this.label,
    this.id,
    this.user,
    this.description,
    this.createdAt,
    this.url,
    this.notas,
  });
}
