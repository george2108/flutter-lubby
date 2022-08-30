import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';

part 'passwords_event.dart';
part 'passwords_state.dart';

class PasswordsBloc extends Bloc<PasswordsEvent, PasswordsState> {
  PasswordsBloc()
      : super(
          PasswordsState(
            passwords: [],
            searchInputController: TextEditingController(),
          ),
        ) {
    on<GetPasswordsEvent>(this.getPasswords);

    on<PasswordsDeletedEvent>(this.deletePassword);

    on<PasswordsHideShowFabEvent>(this.showHideFab);
  }

  // TODO: MEJOR QUITAR DE LA LISTA EL ITEM ELIMINAOD
  Future<void> deletePassword(
    PasswordsDeletedEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    await DatabaseProvider.db.deletePassword(event.id);
    // TODO: checar esto
    // emit(PasswordsDeletedState());
  }

  Future<void> getPasswords(
    GetPasswordsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 1));
    final List<PasswordModel> passwordsData =
        await DatabaseProvider.db.getAllPasswords();

    emit(state.copyWith(
      passwords: passwordsData,
      loading: false,
    ));
  }

  showHideFab(
    PasswordsHideShowFabEvent event,
    Emitter<PasswordsState> emit,
  ) {
    emit(state.copyWith(showFab: event.showFab));
  }
}
