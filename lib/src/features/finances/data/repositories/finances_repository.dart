import 'package:sqflite/sqflite.dart';

import '../../../../data/datasources/local/db/database_service.dart';
import '../../domain/entities/account_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/finances_repository_abstract.dart';
import '../../../../core/constants/db_tables_name_constants.dart';

class FinancesRepository extends FinancesRepositoryAbstract {
  @override
  Future<List<AccountEntity>> getAccounts() async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(kAccountsTable);
    return List.generate(maps.length, (i) {
      return AccountEntity.fromMap(maps[i]);
    });
  }

  @override
  Future<int> addNewAccount(AccountEntity account) async {
    final db = await DatabaseProvider.db.database;
    return await db.insert(kAccountsTable, account.toMap());
  }

  @override
  Future<TransactionEntity> saveTransaction(
    TransactionEntity transaction,
  ) async {
    final db = await DatabaseProvider.db.database;
    final id = await db.insert(
      kTransactionsTable,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.rollback,
    );
    return transaction.copyWith(id: id);
  }

  @override
  Future<List<TransactionEntity>> getTransactions({
    int? accountId,
    DateTime? startDate,
    DateTime? finalDate,
  }) async {
    final db = await DatabaseProvider.db.database;

    // busqueda dinamica si es que tiene filtros o no
    final where = accountId != null
        ? '(accountId = ? OR accountDestId = ?)'
        : startDate != null && finalDate != null
            ? 'date BETWEEN ? AND ?'
            : null;

    final whereArgs = accountId != null

        /// si es que tiene accountId
        ? [accountId, accountId]
        : startDate != null && finalDate != null

            /// si es que tiene fechas
            ? [startDate.toIso8601String(), finalDate.toIso8601String()]
            : null;

    final List<Map<String, dynamic>> maps = await db.query(
      kTransactionsTable,
      where: where,
      whereArgs: whereArgs,
    );

    final List<TransactionEntity> transactions = [];

    for (var i = 0; i < maps.length; i++) {
      final map = maps[i];

      final account = await getAccount(map['accountId']);
      final mapWithAccount = Map<String, dynamic>.from(map);
      mapWithAccount['account'] = account;

      Map<String, dynamic> category = {};
      if (map['labelId'] != null) {
        category = await getCategory(map['labelId']);
      }
      final mapWithCategory = Map<String, dynamic>.from(mapWithAccount);
      mapWithCategory['label'] = category;

      Map<String, dynamic> accountDest = {};
      if (map['accountDestId'] != null) {
        accountDest = await getAccount(map['accountDestId']);
      }
      final mapWithAccountDest = Map<String, dynamic>.from(mapWithCategory);
      mapWithAccountDest['accountDest'] = accountDest;

      transactions.add(TransactionEntity.fromMap(mapWithAccountDest));
    }

    return transactions;
  }

  @override
  Future<Map<String, dynamic>> getCategory(int id) async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      kLabelsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.first;
  }

  @override
  Future<Map<String, dynamic>> getAccount(int id) async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(
      kAccountsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    return maps.first;
  }

  @override
  Future<void> updateAccountSubstract(
    AccountEntity account,
    double amount,
  ) async {
    final db = await DatabaseProvider.db.database;

    final newBalance = account.balance - amount;

    await db.rawUpdate(
      'UPDATE $kAccountsTable SET balance = ? WHERE id = ?',
      [newBalance, account.id],
    );
  }

  @override
  Future<void> updateAccountAdd(
    AccountEntity account,
    double amount,
  ) async {
    final db = await DatabaseProvider.db.database;

    final newBalance = account.balance + amount;

    await db.rawUpdate(
      'UPDATE $kAccountsTable SET balance = ? WHERE id = ?',
      [newBalance, account.id],
    );
  }
}
