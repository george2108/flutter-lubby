import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';

part 'passwords_event.dart';
part 'passwords_state.dart';

class PasswordsBloc extends Bloc<PasswordsEvent, PasswordsState> {
  PasswordsBloc() : super(PasswordsInitialState()) {
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
    emit(PasswordsDeletedState());
  }

  Future<void> getPasswords(
    GetPasswordsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    emit(PasswordsLoadingState(true));
    final List<PasswordModel> passwordsData =
        await DatabaseProvider.db.getAllPasswords();
    emit(PasswordsLoadingState(false));
    emit(PasswordsLoadedPasswordsState(
      passwordsData,
      true,
    ));
  }

  showHideFab(
    PasswordsHideShowFabEvent event,
    Emitter<PasswordsState> emit,
  ) {
    final currentState = state as PasswordsLoadedPasswordsState;
    emit(currentState.copyWith(showFab: event.showFab));
  }
}
