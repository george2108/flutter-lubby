part of 'passwords_bloc.dart';

@immutable
class PasswordsState extends Equatable {
  final List<PasswordEntity> passwords;
  final List<LabelEntity> labels;
  final bool loading;

  const PasswordsState({
    this.passwords = const [],
    this.labels = const [],
    this.loading = false,
  });

  PasswordsState copyWith({
    List<PasswordEntity>? passwords,
    bool? loading,
    List<LabelEntity>? labels,
    PasswordEntity? passwordSelected,
  }) =>
      PasswordsState(
        passwords: passwords ?? this.passwords,
        loading: loading ?? this.loading,
        labels: labels ?? this.labels,
      );

  @override
  List<Object?> get props => [
        passwords,
        loading,
        labels,
      ];
}
