import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';

abstract class FinancesRepositoryAbstract {
  Future<List<AccountEntity>> getAccounts();

  Future<int> addNewAccount(AccountEntity account);
}
