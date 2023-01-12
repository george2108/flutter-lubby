import 'package:lubby_app/src/data/datasources/local/db/database_service.dart';
import 'package:lubby_app/src/domain/repositories/finances_repository_abstract.dart';

import '../../core/constants/db_tables_name_constants.dart';
import '../entities/finances/account_entity.dart';

class FinancesRepository extends FinancesRepositoryAbstract {
  @override
  Future<List<AccountEntity>> getAccounts() async {
    final db = await DatabaseProvider.db.database;
    final List<Map<String, dynamic>> maps = await db.query(kAccountsTable);
    return List.generate(maps.length, (i) {
      return AccountEntity.fromMap(maps[i]);
    });
  }
}
