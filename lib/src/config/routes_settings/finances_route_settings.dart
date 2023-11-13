import 'package:flutter/widgets.dart';

import '../routes/routes.dart';
import '../../features/finances/domain/entities/account_entity.dart';
import '../../features/finances/domain/entities/transaction_entity.dart';

class NewMovementRouteSettings extends RouteSettings {
  final BuildContext movementContext;

  const NewMovementRouteSettings({
    required this.movementContext,
  }) : super(name: financesNewAccountRoute);
}

class ViewAccountRouteSettings extends RouteSettings {
  final BuildContext financesContext;
  final AccountEntity account;

  const ViewAccountRouteSettings({
    required this.financesContext,
    required this.account,
  }) : super(name: financesNewAccountRoute);
}

class TransactionRouteSettings extends RouteSettings {
  final TransactionEntity transaction;

  const TransactionRouteSettings({
    required this.transaction,
  }) : super(name: financesTransactionDetailRoute);
}
