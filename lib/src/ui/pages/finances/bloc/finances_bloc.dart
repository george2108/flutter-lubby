import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/data/repositories/label_repository.dart';

part 'finances_event.dart';
part 'finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  final LabelRepository _labelRepository;
  FinancesBloc(this._labelRepository) : super(const FinancesState()) {
    on<SaveLabelEvent>(saveLabel);

    on<GetLabelsEvent>(getLabels);
  }

  getLabels(
    GetLabelsEvent event,
    Emitter<FinancesState> emit,
  ) async {
    final labels = await _labelRepository.getLabels(TypeLabels.finances);
    print(labels);
    emit(state.copyWith(labels: labels));
  }

  saveLabel(SaveLabelEvent event, Emitter<FinancesState> emit) async {
    final id = await _labelRepository.addNewLabel(event.label);
    final label = event.label.copyWith(id: id);
    final labels = List<LabelEntity>.from(state.labels);
    labels.add(label);
    emit(state.copyWith(labels: labels));
  }
}
