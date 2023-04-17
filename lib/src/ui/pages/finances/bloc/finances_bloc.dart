import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';
import 'package:lubby_app/src/domain/entities/label_entity.dart';
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

    on<GetCategoriesEvent>(getLabels);

    on<GetAccountsEvent>(getAccounts);

    on<CreateAccountEvent>(saveAccount);
  }

  getAccounts(GetAccountsEvent event, Emitter<FinancesState> emit) async {
    final accounts = await _financesRepository.getAccounts();
    emit(state.copyWith(accounts: accounts));
  }

  getLabels(
    GetCategoriesEvent event,
    Emitter<FinancesState> emit,
  ) async {
    final categories = await _labelRepository.getLabels(
      [TypeLabels.expense, TypeLabels.income, TypeLabels.transfer],
    );
    emit(state.copyWith(categories: categories));
  }

  saveLabel(SaveLabelEvent event, Emitter<FinancesState> emit) async {
    final id = await _labelRepository.addNewLabel(event.label);
    final label = event.label.copyWith(id: id);
    final categories = List<LabelEntity>.from(state.categories);
    categories.add(label);
    emit(state.copyWith(categories: categories));
  }

  saveAccount(CreateAccountEvent event, Emitter<FinancesState> emit) async {
    final id = await _financesRepository.addNewAccount(event.account);
    final account = event.account.copyWith(id: id);
    final accounts = List<AccountEntity>.from(state.accounts);
    accounts.add(account);
    emit(CreatedAccountState(account));
    emit(state.copyWith(accounts: accounts));
  }
}
