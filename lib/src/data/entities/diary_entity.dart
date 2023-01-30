import 'package:flutter/material.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/domain/entities/diary_abstract_entity.dart';

class DiaryEntity extends DiaryAbstractEntity {
  const DiaryEntity({
    super.id,
    required super.title,
    super.description,
    required super.startDate,
    super.endDate,
    super.startTime,
    super.endTime,
    super.labelId,
    super.label,
    required super.color,
    required super.typeRepeat,
    required super.daysRepeat,
  });

  factory DiaryEntity.fromMap(Map<String, dynamic> json) {
    return DiaryEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      startTime: json['startTime'] != null
          ? TimeOfDay(
              hour: int.parse(json['startTime'].split(':')[0]),
              minute: int.parse(json['startTime'].split(':')[1]),
            )
          : null,
      endTime: json['endTime'] != null
          ? TimeOfDay(
              hour: int.parse(json['endTime'].split(':')[0]),
              minute: int.parse(json['endTime'].split(':')[1]),
            )
          : null,
      labelId: json['labelId'],
      label: json['label'] != null ? LabelEntity.fromMap(json['label']) : null,
      color: Color(json['color']),
      typeRepeat: json['typeRepeat'],
      daysRepeat: json['daysRepeat'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "startDate": startDate.toIso8601String(),
      "endDate": endDate != null ? endDate!.toIso8601String() : null,
      "startTime": startTime != null
          ? '${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}'
          : null,
      "endTime": endTime != null
          ? '${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}'
          : null,
      "labelId": labelId,
      "color": color.value,
      "typeRepeat": typeRepeat,
      "daysRepeat": daysRepeat,
    };
  }

  DiaryEntity copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    int? labelId,
    LabelEntity? label,
    Color? color,
    String? typeRepeat,
    String? daysRepeat,
  }) =>
      DiaryEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        labelId: labelId ?? this.labelId,
        label: label ?? this.label,
        color: color ?? this.color,
        typeRepeat: typeRepeat ?? this.typeRepeat,
        daysRepeat: daysRepeat ?? this.daysRepeat,
      );

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        startDate,
        endDate,
        startTime,
        endTime,
        labelId,
        label,
        color,
        typeRepeat,
        daysRepeat,
      ];

  @override
  String toString() {
    return 'DiaryEntity(id: $id, title: $title, description: $description, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, labelId: $labelId, label: $label, color: $color, typeRepeat: $typeRepeat, daysRepeat: $daysRepeat)';
  }
}
