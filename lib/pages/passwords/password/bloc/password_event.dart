part of 'password_bloc.dart';

@immutable
abstract class PasswordEvent extends Equatable {}

class LoadInitialPasswordEvent extends PasswordEvent {
  final PasswordModel? password;
  LoadInitialPasswordEvent(this.password);
  @override
  List<Object?> get props => [password];
}

class CreatedPasswordEvent extends PasswordEvent {
  final PasswordModel password;
  CreatedPasswordEvent(this.password);
  @override
  List<Object?> get props => [password];
}

class UpdatedPasswordEvent extends PasswordEvent {
  final PasswordModel password;
  UpdatedPasswordEvent(this.password);
  @override
  List<Object?> get props => [password];
}

class DeletedPasswordEvent extends PasswordEvent {
  final int id;
  DeletedPasswordEvent(this.id);
  @override
  List<Object?> get props => [id];
}
