import '../entities/account_entity.dart';
import '../entities/transaction_entity.dart';

abstract class FinancesRepositoryAbstract {
  Future<List<AccountEntity>> getAccounts();

  Future<int> addNewAccount(AccountEntity account);

  Future<TransactionEntity> saveTransaction(TransactionEntity transaction);

  Future<List<TransactionEntity>> getTransactions({
    int? accountId,
    DateTime? startDate,
    DateTime? finalDate,
  });

  /// ir por la cuenta en map para pasarlo al map de la transaccion
  /// y luego pasarlo al entity
  Future<Map<String, dynamic>> getAccount(int id);

  /// ir por la categoria en map para pasarlo al map de la transaccion
  /// y luego pasarlo al entity
  Future<Map<String, dynamic>> getCategory(int id);

  // descontar el monto de la cuenta
  Future<void> updateAccountSubstract(AccountEntity account, double amount);

  // sumar el monto de la cuenta
  Future<void> updateAccountAdd(AccountEntity account, double amount);
}
