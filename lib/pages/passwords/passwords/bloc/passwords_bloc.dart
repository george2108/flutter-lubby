import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/db/database_provider.dart';
import 'package:lubby_app/models/password_model.dart';
import 'package:lubby_app/services/password_service.dart';
import 'package:meta/meta.dart';

part 'passwords_event.dart';
part 'passwords_state.dart';

class PasswordsBloc extends Bloc<PasswordsEvent, PasswordsState> {
  PasswordsBloc() : super(PasswordsInitialState()) {
    on<GetPasswordsEvent>(this.getPasswords);
  }

  Future<void> getPasswords(
    GetPasswordsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    emit(PasswordsLoadingState(true));
    final List<PasswordModel> passwordsData =
        await DatabaseProvider.db.getAllPasswords();
    emit(PasswordsLoadingState(false));
    emit(PasswordsLoadedPasswordsState(
      passwordsData,
    ));
  }
}
