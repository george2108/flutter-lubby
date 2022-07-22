part of 'password_bloc.dart';

@immutable
abstract class PasswordEvent extends Equatable {}

class LoadInitialPasswordEvent extends PasswordEvent {
  final PasswordModel? password;
  LoadInitialPasswordEvent(this.password);
  @override
  List<Object?> get props => [password];
}

class PasswordCreatedEvent extends PasswordEvent {
  @override
  List<Object?> get props => [];
}

class PasswordUpdatedEvent extends PasswordEvent {
  @override
  List<Object?> get props => [];
}

class PasswordDeletedEvent extends PasswordEvent {
  final int id;
  PasswordDeletedEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class PasswordShowedEvent extends PasswordEvent {
  @override
  List<Object?> get props => [];
}
