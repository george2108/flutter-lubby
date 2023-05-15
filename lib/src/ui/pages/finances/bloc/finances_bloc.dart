import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/core/enums/type_labels.enum.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';
import 'package:lubby_app/src/domain/entities/finances/transaction_entity.dart';
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
    on<AddLabelEvent>(addLabel);

    on<GetCategoriesEvent>(getLabels);

    on<GetAccountsEvent>(getAccounts);

    on<CreateAccountEvent>(saveAccount);

    on<CreateTransactionEvent>(saveTransaction);

    on<GetTransactionsEvent>(getTransactions);
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

  getTransactions(
    GetTransactionsEvent event,
    Emitter<FinancesState> emit,
  ) async {
    final transactions = await _financesRepository.getTransactions();
    emit(state.copyWith(transactions: transactions));
  }

  addLabel(AddLabelEvent event, Emitter<FinancesState> emit) async {
    final categories = List<LabelEntity>.from(state.categories);
    categories.add(event.label);
    emit(state.copyWith(categories: categories));
  }

  saveAccount(CreateAccountEvent event, Emitter<FinancesState> emit) async {
    final id = await _financesRepository.addNewAccount(event.account);
    final account = event.account.copyWith(id: id);
    final accounts = List<AccountEntity>.from(state.accounts);
    accounts.add(account);
    emit(state.copyWith(accounts: accounts));
  }

  saveTransaction(
    CreateTransactionEvent event,
    Emitter<FinancesState> emit,
  ) async {
    if (event.transaction.type == TypeLabels.transfer.name) {
      await _financesRepository.updateAccountSubstract(
        event.transaction.account,
        event.transaction.amount,
      );
      await _financesRepository.updateAccountAdd(
        event.transaction.accountDest!,
        event.transaction.amount,
      );

      List<AccountEntity> accounts = List<AccountEntity>.from(state.accounts);

      final indexAccount = accounts.indexWhere(
        (acc) => acc.id == event.transaction.account.id,
      );
      if (indexAccount > -1) {
        accounts[indexAccount] = accounts[indexAccount].copyWith(
          balance: accounts[indexAccount].balance - event.transaction.amount,
        );
      }

      final indexAccountDest = accounts.indexWhere(
        (acc) => acc.id == event.transaction.accountDest!.id,
      );
      if (indexAccountDest > -1) {
        accounts[indexAccountDest] = accounts[indexAccountDest].copyWith(
          balance:
              accounts[indexAccountDest].balance + event.transaction.amount,
        );
      }

      emit(state.copyWith(accounts: accounts));
    }

    if (event.transaction.type == TypeLabels.expense.name) {
      await _financesRepository.updateAccountSubstract(
        event.transaction.account,
        event.transaction.amount,
      );
      List<AccountEntity> accounts = List<AccountEntity>.from(state.accounts);
      final indexAccount = accounts.indexWhere(
        (acc) => acc.id == event.transaction.account.id,
      );
      if (indexAccount > -1) {
        accounts[indexAccount] = accounts[indexAccount].copyWith(
          balance: accounts[indexAccount].balance - event.transaction.amount,
        );
      }
      emit(state.copyWith(accounts: accounts));
    }

    if (event.transaction.type == TypeLabels.income.name) {
      await _financesRepository.updateAccountAdd(
        event.transaction.account,
        event.transaction.amount,
      );
      List<AccountEntity> accounts = List<AccountEntity>.from(state.accounts);
      final indexAccount = accounts.indexWhere(
        (acc) => acc.id == event.transaction.account.id,
      );
      if (indexAccount > -1) {
        accounts[indexAccount] = accounts[indexAccount].copyWith(
          balance: accounts[indexAccount].balance + event.transaction.amount,
        );
      }
      emit(state.copyWith(accounts: accounts));
    }

    final transaction = await _financesRepository.saveTransaction(
      event.transaction,
    );
    final transactions = List<TransactionEntity>.from(state.transactions);
    transactions.add(transaction);
    emit(state.copyWith(transactions: transactions));
  }
}
