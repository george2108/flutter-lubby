import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:lubby_app/services/password_service.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordService _passwordService;

  PasswordBloc(this._passwordService) : super(PasswordInitialState()) {
    on<LoadInitialPasswordEvent>(this.loadPasswordInitial);

    on<PasswordCreatedEvent>(this.createPassword);

    on<PasswordUpdatedEvent>(this.updatePassword);

    on<PasswordShowedEvent>(this.showPassword);

    on<PasswordMarkedFavorite>(this.markPasswordFavorite);
  }

  loadPasswordInitial(
    LoadInitialPasswordEvent event,
    Emitter<PasswordState> emit,
  ) {
    final String passDecrypted = event.password == null
        ? ''
        : this._passwordService.decrypt(event.password!.password);
    emit(PasswordLoadedState(
      editing: event.password != null,
      password: event.password,
      formKey: GlobalKey<FormState>(),
      titleController: TextEditingController(text: event.password?.title ?? ''),
      userController: TextEditingController(text: event.password?.user ?? ''),
      passwordController: TextEditingController(text: passDecrypted),
      descriptionController:
          TextEditingController(text: event.password?.description ?? ''),
      favorite: event.password?.favorite == 1,
    ));
  }

  createPassword(
    PasswordCreatedEvent event,
    Emitter<PasswordState> emit,
  ) async {
    try {
      final currentState = state as PasswordLoadedState;
      final PasswordModel passwordModel = PasswordModel(
        title: currentState.titleController.text,
        password: currentState.passwordController.text,
        createdAt: DateTime.now(),
        description: currentState.descriptionController.text,
        user: currentState.userController.text,
        favorite: currentState.favorite ? 1 : 0,
      );

      // encripta la contraseña
      passwordModel.password =
          _passwordService.encrypt(passwordModel.password.toString());

      await DatabaseProvider.db.addNewPassword(passwordModel);
      emit(PasswordCreatedState());
    } catch (e) {
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
    final currentState = state as PasswordLoadedState;
    emit(
      currentState.copyWith(obscurePassword: !currentState.obscurePassword),
    );
  }

  markPasswordFavorite(
    PasswordMarkedFavorite event,
    Emitter<PasswordState> emit,
  ) {
    final currentState = state as PasswordLoadedState;
    emit(currentState.copyWith(favorite: !currentState.favorite));
  }
}
