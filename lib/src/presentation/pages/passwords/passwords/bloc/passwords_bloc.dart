import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/data/models/password_model.dart';

import '../../../../../data/datasources/local/services/passwords_local_service.dart';

part 'passwords_event.dart';
part 'passwords_state.dart';

class PasswordsBloc extends Bloc<PasswordsEvent, PasswordsState> {
  PasswordsBloc()
      : super(
          PasswordsState(
            passwords: const [],
            searchInputController: TextEditingController(),
          ),
        ) {
    on<GetPasswordsEvent>(getPasswords);

    on<PasswordsDeletedEvent>(deletePassword);

    on<PasswordsHideShowFabEvent>(showHideFab);
  }

  Future<void> deletePassword(
    PasswordsDeletedEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    final deleteResult =
        await PasswordsLocalService.provider.deletePassword(event.id);
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
        await PasswordsLocalService.provider.getAllPasswords();

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
