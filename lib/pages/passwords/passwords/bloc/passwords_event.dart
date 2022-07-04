part of 'passwords_bloc.dart';

@immutable
abstract class PasswordsEvent extends Equatable {}

class GetPasswordsEvent extends PasswordsEvent {
  @override
  List<Object?> get props => [];
}
