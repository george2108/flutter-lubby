import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/data/entities/finances/account_entity.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/data/repositories/finances_repository.dart';
import 'package:lubby_app/src/data/repositories/label_repository.dart';

part 'finances_event.dart';
part 'finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  final LabelRepository _labelRepository;
  final FinancesRepository _financesRepository;

  FinancesBloc(
    this._labelRepository,
    this._financesRepository,
  ) : super(const FinancesState()) {
    on<SaveLabelEvent>(saveLabel);

    on<GetLabelsEvent>(getLabels);

    on<GetAccountsEvent>(getAccounts);
  }

  getAccounts(GetAccountsEvent event, Emitter<FinancesState> emit) async {
    final accounts = await _financesRepository.getAccounts();
    print(accounts);
    emit(state.copyWith(accounts: accounts));
  }

  getLabels(
    GetLabelsEvent event,
    Emitter<FinancesState> emit,
  ) async {
    final labels = await _labelRepository.getLabels(TypeLabels.finances);
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
