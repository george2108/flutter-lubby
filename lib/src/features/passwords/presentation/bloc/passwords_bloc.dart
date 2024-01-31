import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/enums/type_labels.enum.dart';
import '../../../labels/domain/entities/label_entity.dart';
import '../../entities/password_entity.dart';
import '../../../labels/data/repositories/label_repository.dart';
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

    on<PasswordsDeletedEvent>(deletePassword);

    on<CreatePasswordEvent>(createPassword);

    on<UpdatePasswordEvent>(updatePassword);

    on<GetLabelsEvent>(getLabels);

    on<AddLabelEvent>(addLabel);
  }

  Future<void> deletePassword(
    PasswordsDeletedEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    /* final deleteResult =
        await PasswordsLocalService.provider.deletePassword(event.id);
    if (deleteResult > 0) {
      // emitir nueva lista sin el elemento que ha sido borrado
      final nuevaLista = List<PasswordEntity>.from(state.passwords)
          .where((element) => element.id != event.id)
          .toList();
      emit(state.copyWith(
        passwords: nuevaLista,
      ));
    } */
  }

  Future<void> getPasswords(
    GetPasswordsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 1));
    final List<PasswordEntity> passwordsData =
        await _passwordRepository.getAllPasswords();

    for (var i = 0; i < passwordsData.length; i++) {
      final pass = passwordsData[i];
      if (pass.labelId != null) {
        final label = await _labelRepository.getLabelById(pass.labelId!);
        passwordsData[i] = passwordsData[i].copyWith(label: label);
      }
    }

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
        ..insert(0, event.password.copyWith(id: id));

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

    /* try {
      final response =
          await PasswordsLocalService.provider.updatePassword(event.password);

      if (response > 0) {
        // emitir nueva lista con el elemento que ha sido actualizado
        final nuevaLista = List<PasswordEntity>.from(state.passwords)
          ..removeWhere((element) => element.id == event.password.id)
          ..add(event.password);
        emit(state.copyWith(loading: false, passwords: nuevaLista));
      } else {
        emit(state.copyWith(loading: false));
      }
    } catch (e) {
      emit(state.copyWith(loading: false));
    } */
  }

  Future<void> getLabels(
    GetLabelsEvent event,
    Emitter<PasswordsState> emit,
  ) async {
    emit(state.copyWith(loading: true));

    await Future.delayed(const Duration(seconds: 1));
    final List<LabelEntity> labelsData = await _labelRepository.getLabels(
      [TypeLabels.passwords],
    );

    emit(state.copyWith(
      labels: labelsData,
      loading: false,
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
