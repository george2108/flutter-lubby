part of 'passwords_bloc.dart';

class PasswordsState extends Equatable {
  final List<PasswordEntity> passwords;
  final List<LabelEntity> labels;
  final bool loading;
  final PasswordsFilterOptionsModel filters;

  const PasswordsState({
    this.passwords = const [],
    this.labels = const [],
    this.loading = true,
    this.filters = const PasswordsFilterOptionsModel(),
  });

  PasswordsState copyWith({
    List<PasswordEntity>? passwords,
    bool? loading,
    List<LabelEntity>? labels,
    PasswordEntity? passwordSelected,
    PasswordsFilterOptionsModel? filters,
  }) =>
      PasswordsState(
        passwords: passwords ?? this.passwords,
        loading: loading ?? this.loading,
        labels: labels ?? this.labels,
        filters: filters ?? this.filters,
      );

  @override
  List<Object?> get props => [
        passwords,
        loading,
        labels,
        filters,
      ];
}
