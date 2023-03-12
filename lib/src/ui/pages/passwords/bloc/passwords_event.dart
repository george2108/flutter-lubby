part of 'passwords_bloc.dart';

abstract class PasswordsEvent extends Equatable {
  const PasswordsEvent();
}

class GetPasswordsEvent extends PasswordsEvent {
  @override
  List<Object?> get props => [];
}

class PasswordsDeletedEvent extends PasswordsEvent {
  final int id;

  const PasswordsDeletedEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class CreatePasswordEvent extends PasswordsEvent {
  final PasswordEntity password;

  const CreatePasswordEvent(this.password);

  @override
  List<Object?> get props => [
        password,
      ];
}

class UpdatePasswordEvent extends PasswordsEvent {
  final PasswordEntity password;

  const UpdatePasswordEvent(this.password);

  @override
  List<Object?> get props => [
        password,
      ];
}

class DeletePasswordEvent extends PasswordsEvent {
  final int id;

  const DeletePasswordEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetLabelsEvent extends PasswordsEvent {
  @override
  List<Object?> get props => [];
}

class CreateLabelEvent extends PasswordsEvent {
  final LabelEntity label;

  const CreateLabelEvent(this.label);

  @override
  List<Object?> get props => [
        label,
      ];
}