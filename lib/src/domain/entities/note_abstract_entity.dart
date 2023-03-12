import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';

abstract class NoteAbstractEntity extends Equatable {
  final int? id;
  final String title;
  final String body;
  final DateTime createdAt;
  final bool favorite;
  final Color color;
  final LabelEntity? label;
  final int? labelId;

  const NoteAbstractEntity({
    this.id,
    this.label,
    this.labelId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.favorite,
    required this.color,
  });

  Map<String, dynamic> toMap();

  NoteAbstractEntity copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    bool? favorite,
    Color? color,
    LabelEntity? label,
    int? labelId,
  });

  @override
  bool? get stringify => true;
}
