part of 'passwords_bloc.dart';

class PasswordsState extends Equatable {
  final List<PasswordEntity> passwords;
  final bool loading;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const PasswordsState({
    this.passwords = const [],
    this.loading = false,
    required this.scaffoldKey,
  });

  PasswordsState copyWith({
    List<PasswordEntity>? passwords,
    bool? loading,
  }) =>
      PasswordsState(
        passwords: passwords ?? this.passwords,
        loading: loading ?? this.loading,
        scaffoldKey: scaffoldKey,
      );

  @override
  List<Object?> get props => [
        passwords,
        loading,
        scaffoldKey,
      ];
}
