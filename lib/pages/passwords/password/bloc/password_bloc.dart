import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/pages/passwords/password/password_status_enum.dart';

import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordService _passwordService;
  final PasswordModel? password;

  PasswordBloc(this._passwordService, this.password)
      : super(PasswordState(
          editing: password != null,
          password: password,
          formKey: GlobalKey<FormState>(),
          titleController: TextEditingController(text: password?.title ?? ''),
          userController: TextEditingController(text: password?.user ?? ''),
          passwordController: TextEditingController(
              text: password == null
                  ? ''
                  : _passwordService.decrypt(password.password)),
          descriptionController:
              TextEditingController(text: password?.description ?? ''),
          favorite: password?.favorite == 1,
        )) {
    on<PasswordCreatedEvent>(this.createPassword);

    on<PasswordUpdatedEvent>(this.updatePassword);

    on<PasswordShowedEvent>(this.showPassword);

    on<PasswordMarkedFavorite>(this.markPasswordFavorite);
  }

  createPassword(
    PasswordCreatedEvent event,
    Emitter<PasswordState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final PasswordModel passwordModel = PasswordModel(
        title: state.titleController.text,
        password: state.passwordController.text,
        createdAt: DateTime.now(),
        description: state.descriptionController.text,
        user: state.userController.text,
        favorite: state.favorite ? 1 : 0,
      );

      // encripta la contraseña
      passwordModel.password =
          _passwordService.encrypt(passwordModel.password.toString());

      await DatabaseProvider.db.addNewPassword(passwordModel);

      emit(state.copyWith(
        status: PasswordStatusEnum.created,
        loading: false,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
      print(e);
    }
  }

  updatePassword(
    PasswordUpdatedEvent event,
    Emitter<PasswordState> emit,
  ) async {
    /* try {
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
    } */
  }

  showPassword(PasswordShowedEvent event, Emitter<PasswordState> emit) {
    emit(
      state.copyWith(obscurePassword: !state.obscurePassword),
    );
  }

  markPasswordFavorite(
    PasswordMarkedFavorite event,
    Emitter<PasswordState> emit,
  ) {
    emit(state.copyWith(favorite: !state.favorite));
  }
}
