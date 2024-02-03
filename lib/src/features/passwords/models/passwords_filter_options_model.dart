import 'package:equatable/equatable.dart';

import '../../labels/domain/entities/label_entity.dart';

class PasswordsFilterOptionsModel extends Equatable {
  final String? search;
  final LabelEntity? label;

  const PasswordsFilterOptionsModel({
    this.search,
    this.label,
  });

  PasswordsFilterOptionsModel copyWith({
    String? search,
    LabelEntity? label,
  }) =>
      PasswordsFilterOptionsModel(
        search: search ?? this.search,
        label: label ?? this.label,
      );

  @override
  List<Object?> get props => [label, search];
}
