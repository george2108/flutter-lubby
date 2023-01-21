import 'dart:ui';

import 'package:equatable/equatable.dart';

abstract class NoteAbstractEntity extends Equatable {
  final int? id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool favorite;
  final Color color;

  const NoteAbstractEntity({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.favorite,
    required this.color,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        createdAt,
        favorite,
        color,
      ];

  Map<String, dynamic> toMap();

  NoteAbstractEntity copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? favorite,
    Color? color,
  });

  @override
  bool? get stringify => true;
}
