part of 'passwords_bloc.dart';

abstract class PasswordsEvent extends Equatable {
  const PasswordsEvent();
}

class GetPasswordsEvent extends PasswordsEvent {
  final PasswordsFilterOptionsModel? filters;

  const GetPasswordsEvent({this.filters});

  @override
  List<Object?> get props => [filters];
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

class AddLabelEvent extends PasswordsEvent {
  final LabelEntity label;

  const AddLabelEvent(this.label);

  @override
  List<Object?> get props => [label];
}

class SearchPasswordActionEvent extends PasswordsEvent {
  final bool isSearching;

  const SearchPasswordActionEvent({required this.isSearching});

  @override
  List<Object?> get props => [isSearching];
}
