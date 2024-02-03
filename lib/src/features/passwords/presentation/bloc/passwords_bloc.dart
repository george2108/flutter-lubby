import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/type_labels.enum.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../../entities/password_entity.dart';
import '../../../labels/data/repositories/label_repository.dart';
import '../../models/passwords_filter_options_model.dart';
import '../../repositories/password_repository.dart';

part 'passwords_event.dart';
part 'passwords_state.dart';

class PasswordsBloc extends Bloc<PasswordsEvent, PasswordsState> {
  final PasswordRepository _passwordRepository;
  final LabelRepository _labelRepository;

  PasswordsBloc(
    this._passwordRepository,
    this._labelRepository,
  ) : super(const PasswordsState()) {
    on<GetPasswordsEvent>(getPasswords);

    on<DeletePasswordEvent>(deletePassword);

    on<CreatePasswordEvent>(createPassword);

    on<UpdatePasswordEvent>(updatePassword);

    on<GetLabelsEvent>(getLabels);

    on<AddLabelEvent>(addLabel);

    on<SearchPasswordActionEvent>(searchPassword);
  }

  void searchPassword(
    SearchPasswordActionEvent event,
    Emitter<PasswordsState> emit,
  ) {
    emit(state.copyWith(searching: event.isSearching));
  }

  Future<void> deletePassword(
    DeletePasswordEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    final deleteResult = await _passwordRepository.deletePassword(event.id);
    if (deleteResult > 0) {
      // emitir nueva lista sin el elemento que ha sido borrado
      final nuevaLista = List<PasswordEntity>.from(state.passwords)
          .where((element) => element.appId != event.id)
          .toList();
      emit(state.copyWith(
        passwords: nuevaLista,
      ));
    }
  }

  Future<void> getPasswords(
    GetPasswordsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    final newFilters = PasswordsFilterOptionsModel(
      label: event.filters?.label,
      search: event.filters?.search,
    );
    emit(state.copyWith(
      loading: true,
      filters: newFilters,
    ));

    final List<PasswordEntity> passwordsData =
        await _passwordRepository.getAllPasswords(filters: newFilters);

    emit(state.copyWith(
      passwords: passwordsData,
      loading: false,
    ));
  }

  createPassword(
    CreatePasswordEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    emit(state.copyWith(loading: true));
    try {
      // encripta la contraseña
      final id = await _passwordRepository.addNewPassword(event.password);
      // emitir nueva lista con el elemento que ha sido creado
      final nuevaLista = List<PasswordEntity>.from(state.passwords)
        ..insert(0, event.password.copyWith(appId: id));

      emit(state.copyWith(
        passwords: nuevaLista,
        loading: false,
      ));
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  updatePassword(
    UpdatePasswordEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    try {
      final response = await _passwordRepository.updatePassword(
        event.password,
      );

      if (response > 0) {
        final nuevaLista = List<PasswordEntity>.from(state.passwords);
        final element = nuevaLista.indexWhere(
          (element) => element.appId == event.password.appId,
        );
        if (element > -1) {
          nuevaLista[element] = event.password;
        }

        emit(state.copyWith(loading: false, passwords: nuevaLista));
      } else {
        emit(state.copyWith(loading: false));
      }
    } catch (e) {
      emit(state.copyWith(loading: false));
    }
  }

  Future<void> getLabels(
    GetLabelsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    final List<LabelEntity> labelsData = await _labelRepository.getLabels(
      [TypeLabels.passwords],
    );

    emit(state.copyWith(
      labels: labelsData,
    ));
  }

  Future<void> addLabel(
    AddLabelEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    final labels = List<LabelEntity>.from(state.labels);
    labels.add(event.label);
    emit(state.copyWith(labels: labels));
  }
}
