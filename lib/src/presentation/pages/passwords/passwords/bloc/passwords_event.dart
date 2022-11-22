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

class PasswordsHideShowFabEvent extends PasswordsEvent {
  final bool showFab;

  const PasswordsHideShowFabEvent(this.showFab);

  @override
  List<Object?> get props => [showFab];
}
