import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lubby_app/src/core/constants/constants.dart';
import 'package:lubby_app/src/core/enums/status_crud_enum.dart';

import 'package:lubby_app/src/data/datasources/local/services/password_service.dart';
import 'package:lubby_app/src/data/entities/password_entity.dart';

import '../../../../../data/datasources/local/services/passwords_local_service.dart';
import '../../passwords/bloc/passwords_bloc.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordService _passwordService;
  final PasswordEntity? password;
  final PasswordsBloc passwordsBloc;

  PasswordBloc(
    this._passwordService,
    this.passwordsBloc,
    this.password,
  ) : super(
          PasswordState(
            editing: password != null,
            password: password,
            formKey: GlobalKey<FormState>(),
            titleController: TextEditingController(text: password?.title ?? ''),
            userController: TextEditingController(text: password?.user ?? ''),
            urlController: TextEditingController(text: password?.url ?? ''),
            notasController: TextEditingController(text: password?.notas ?? ''),
            passwordController: TextEditingController(
              text: password == null
                  ? ''
                  : _passwordService.decrypt(password.password),
            ),
            descriptionController: TextEditingController(
              text: password?.description ?? '',
            ),
            favorite: password?.favorite == 1,
            color: password?.color ?? kDefaultColorPick,
          ),
        ) {
    on<PasswordCreatedEvent>(createPassword);

    on<PasswordUpdatedEvent>(updatePassword);

    on<PasswordShowedEvent>(showPassword);

    on<PasswordMarkedFavorite>(markPasswordFavorite);

    on<PasswordChangeColorEvent>(changeColor);
  }

  createPassword(
    PasswordCreatedEvent event,
    Emitter<PasswordState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      final PasswordEntity passwordEntPasswordEntity = PasswordEntity(
        title: state.titleController.text,
        password: state.passwordController.text,
        createdAt: DateTime.now(),
        description: state.descriptionController.text,
        user: state.userController.text,
        url: state.urlController.text,
        notas: state.notasController.text,
        favorite: state.favorite ? 1 : 0,
        color: state.color,
      );

      // encripta la contraseña
      passwordEntPasswordEntity.copyWith(
        password: _passwordService
            .encrypt(passwordEntPasswordEntity.password.toString()),
      );

      await PasswordsLocalService.provider
          .addNewPassword(passwordEntPasswordEntity);

      emit(state.copyWith(
        status: StatusCrudEnum.created,
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
    emit(state.copyWith(loading: true));
    try {
      final passwordEncrypted =
          _passwordService.encrypt(state.passwordController.text);
      final PasswordEntity password = state.password!.copyWith(
        title: state.titleController.text,
        password: passwordEncrypted,
        description: state.descriptionController.text,
        user: state.userController.text,
        url: state.urlController.text,
        notas: state.notasController.text,
        favorite: state.favorite ? 1 : 0,
        color: state.color,
      );
      final response =
          await PasswordsLocalService.provider.updatePassword(password);
      if (response > 0) {
        // llamar evento del bloc de passwords para actualizar la lista de contraseñas
        passwordsBloc.add(GetPasswordsEvent());
        emit(state.copyWith(loading: false, status: StatusCrudEnum.updated));
        // emite nuevo status para que no muestre muchas alertas al actualizar
        emit(state.copyWith(status: StatusCrudEnum.none));
      } else {
        emit(state.copyWith(loading: false));
      }
    } catch (e) {
      emit(state.copyWith(loading: false, status: StatusCrudEnum.error));
    }
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

  changeColor(
    PasswordChangeColorEvent event,
    Emitter<PasswordState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  @override
  Future<void> close() async {
    state.titleController.dispose();
    state.userController.dispose();
    state.passwordController.dispose();
    state.descriptionController.dispose();
    state.urlController.dispose();
    state.notasController.dispose();
    return super.close();
  }
}
