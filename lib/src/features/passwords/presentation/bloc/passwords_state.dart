part of 'passwords_bloc.dart';

class PasswordsState extends Equatable {
  final List<PasswordEntity> passwords;
  final List<LabelEntity> labels;
  final bool loading;
  final PasswordEntity passwordSelected;

  const PasswordsState({
    this.passwords = const [],
    this.labels = const [],
    this.loading = false,
    this.passwordSelected = const PasswordEntity(
      title: '',
      password: '',
      favorite: false,
      color: kDefaultColorPick,
      icon: Icons.lock,
    ),
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
        passwordSelected: passwordSelected ?? this.passwordSelected,
      );

  @override
  List<Object?> get props => [
        passwords,
        loading,
        labels,
        passwordSelected,
      ];
}
