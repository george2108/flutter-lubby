import 'package:lubby_app/src/data/entities/finances/account_entity.dart';

abstract class FinancesRepositoryAbstract {
  Future<List<AccountEntity>> getAccounts();
}
