import 'dart:ui';

import 'package:equatable/equatable.dart';

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

  const PasswordAbstractEntity({
    required this.title,
    required this.password,
    required this.favorite,
    required this.color,
    this.id,
    this.user,
    this.description,
    this.createdAt,
    this.url,
    this.notas,
  });
}
