part of 'password_bloc.dart';

@immutable
class PasswordState extends Equatable {
  final PasswordModel? password;

  final bool favorite;
  final TextEditingController titleController;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final TextEditingController descriptionController;

  final bool loading;
  final bool obscurePassword;
  final bool editing;
  final GlobalKey<FormState> formKey;
  final PasswordStatusEnum status;

  PasswordState({
    required this.editing,
    required this.titleController,
    required this.userController,
    required this.passwordController,
    required this.descriptionController,
    required this.formKey,
    required this.favorite,
    this.loading = false,
    this.status = PasswordStatusEnum.none,
    this.password,
    this.obscurePassword = true,
  });

  PasswordState copyWith({
    bool? obscurePassword,
    bool? favorite,
    bool? loading,
    PasswordStatusEnum? status,
  }) =>
      PasswordState(
        editing: this.editing,
        titleController: this.titleController,
        userController: this.userController,
        passwordController: this.passwordController,
        descriptionController: this.descriptionController,
        formKey: this.formKey,
        loading: loading ?? this.loading,
        password: this.password,
        favorite: favorite ?? this.favorite,
        obscurePassword: obscurePassword ?? this.obscurePassword,
        status: status ?? this.status,
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
        status,
      ];
}
