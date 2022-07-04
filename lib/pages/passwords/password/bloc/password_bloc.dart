import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/providers/passwords_provider.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:meta/meta.dart';

import 'package:lubby_app/models/password_model.dart';
part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordService _passwordService;

  PasswordBloc(this._passwordService) : super(PasswordInitialState()) {
    on<LoadInitialPasswordEvent>(loadPasswordInitial);

    on<CreatedPasswordEvent>(createPassword);

    on<UpdatedPasswordEvent>(updatePassword);
  }

  loadPasswordInitial(
    LoadInitialPasswordEvent event,
    Emitter<PasswordState> emit,
  ) {
    if (event.password == null) {
      emit(PasswordLoadedState(
        false,
        event.password,
      ));
      return;
    }
    emit(PasswordLoadedState(
      true,
      event.password,
    ));
  }

  createPassword(
    CreatedPasswordEvent event,
    Emitter<PasswordState> emit,
  ) async {
    try {
      final PasswordModel passwordModel = event.password;

      // encripta la contraseña
      passwordModel.password =
          _passwordService.encrypt(passwordModel.password.toString());
      passwordModel.createdAt = DateTime.now();

      await DatabaseProvider.db.addNewPassword(passwordModel);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  updatePassword(
    UpdatedPasswordEvent event,
    Emitter<PasswordState> emit,
  ) async {
    try {
      final PasswordModel passwordModel = event.password;
      passwordModel.password =
          _passwordService.encrypt(passwordModel.password.toString());
      print(passwordModel.id);

      final response = await DatabaseProvider.db.updatePassword(passwordModel);
      print(response);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
