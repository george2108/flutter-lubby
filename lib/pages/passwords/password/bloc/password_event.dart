part of 'password_bloc.dart';

@immutable
abstract class PasswordEvent extends Equatable {}

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

class PasswordMarkedFavorite extends PasswordEvent {
  @override
  List<Object?> get props => [];
}
