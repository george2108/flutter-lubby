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

  Future<void> deletePassword(
    PasswordsDeletedEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    final deleteResult = await DatabaseProvider.db.deletePassword(event.id);
    if (deleteResult > 0) {
      final toDelete = state.passwords.firstWhere(
        (element) => element.id == event.id,
      );
      // emitir nueva lista sin el elemento que ha sido borrado
      final nuevaLista = List<PasswordModel>.from(state.passwords)
          .where((element) => element.id != event.id)
          .toList();
      emit(state.copyWith(
        passwords: nuevaLista,
        lastPassDeleted: toDelete,
      ));
    }
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
