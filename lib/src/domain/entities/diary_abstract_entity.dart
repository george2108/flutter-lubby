import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/domain/entities/label_abstract_entity.dart';

abstract class DiaryAbstractEntity extends Equatable {
  final int? id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int? labelId;
  final LabelAbstractEntity? label;
  final Color color;
  final String typeRepeat;
  final String daysRepeat;

  const DiaryAbstractEntity({
    this.id,
    required this.title,
    this.description,
    required this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.labelId,
    this.label,
    required this.color,
    required this.typeRepeat,
    required this.daysRepeat,
  });
}
