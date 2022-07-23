part of 'password_bloc.dart';

@immutable
abstract class PasswordState extends Equatable {}

class PasswordInitialState extends PasswordState {
  @override
  List<Object?> get props => [];
}

class PasswordLoadedState extends PasswordState {
  final PasswordModel? password;
  final bool editing;
  final bool favorite;
  final bool loading;
  final bool obscurePassword;
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final TextEditingController descriptionController;

  PasswordLoadedState({
    required this.editing,
    required this.titleController,
    required this.userController,
    required this.passwordController,
    required this.descriptionController,
    required this.formKey,
    required this.favorite,
    this.loading = false,
    this.password,
    this.obscurePassword = true,
  });

  PasswordLoadedState copyWith({
    bool? obscurePassword,
    bool? favorite,
  }) =>
      PasswordLoadedState(
        editing: this.editing,
        titleController: this.titleController,
        userController: this.userController,
        passwordController: this.passwordController,
        descriptionController: this.descriptionController,
        formKey: this.formKey,
        loading: this.loading,
        password: this.password,
        favorite: favorite ?? this.favorite,
        obscurePassword: obscurePassword ?? this.obscurePassword,
      );

  @override
  List<Object?> get props => [
        password,
        editing,
        titleController,
        userController,
        passwordController,
        descriptionController,
        loading,
        obscurePassword,
        formKey,
        favorite,
      ];
}

class PasswordCreatedState extends PasswordState {
  @override
  List<Object?> get props => [];
}
