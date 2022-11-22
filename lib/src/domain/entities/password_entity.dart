import 'dart:ui';

import 'package:equatable/equatable.dart';

class Password extends Equatable {
  final int? id;
  final String password;
  final String title;
  final int favorite;
  final String? user;
  final String? description;
  final DateTime? createdAt;
  final String? url;
  final String? notas;
  final Color color;

  const Password({
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

  @override
  List<Object?> get props => [
        id,
        password,
        title,
        favorite,
        user,
        description,
        createdAt,
        url,
        notas,
        color,
      ];

  @override
  bool? get stringify => true;
}
