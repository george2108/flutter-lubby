import 'package:equatable/equatable.dart';

import '../enums/repeat_type_enum.dart';

class RepeatTimeModel extends Equatable {
  final RepeatType repeatType;
  final String? daysOfWeek;

  const RepeatTimeModel({
    required this.repeatType,
    this.daysOfWeek,
  });

  copyWith({
    RepeatType? repeatType,
    String? daysOfWeek,
  }) {
    return RepeatTimeModel(
      repeatType: repeatType ?? this.repeatType,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    );
  }

  @override
  bool? get stringify => super.stringify;

  @override
  List<Object?> get props => [repeatType, daysOfWeek];
}
