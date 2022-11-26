part of 'password_bloc.dart';

@immutable
class PasswordState extends Equatable {
  final PasswordModel? password;

  final bool favorite;
  final TextEditingController titleController;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final TextEditingController descriptionController;
  final TextEditingController urlController;
  final TextEditingController notasController;
  final Color color;

  final bool loading;
  final bool obscurePassword;
  final bool editing;
  final GlobalKey<FormState> formKey;
  final StatusCrudEnum status;

  const PasswordState({
    required this.editing,
    required this.titleController,
    required this.userController,
    required this.passwordController,
    required this.descriptionController,
    required this.urlController,
    required this.notasController,
    required this.formKey,
    required this.favorite,
    required this.color,
    this.loading = false,
    this.status = StatusCrudEnum.none,
    this.password,
    this.obscurePassword = true,
  });

  PasswordState copyWith({
    bool? obscurePassword,
    bool? favorite,
    bool? loading,
    StatusCrudEnum? status,
    Color? color,
  }) =>
      PasswordState(
        editing: editing,
        titleController: titleController,
        userController: userController,
        passwordController: passwordController,
        descriptionController: descriptionController,
        notasController: notasController,
        urlController: urlController,
        formKey: formKey,
        loading: loading ?? this.loading,
        password: password,
        favorite: favorite ?? this.favorite,
        obscurePassword: obscurePassword ?? this.obscurePassword,
        status: status ?? this.status,
        color: color ?? this.color,
      );

  @override
  List<Object?> get props => [
        password,
        editing,
        titleController,
        userController,
        passwordController,
        descriptionController,
        urlController,
        notasController,
        loading,
        obscurePassword,
        formKey,
        favorite,
        status,
        color,
      ];
}