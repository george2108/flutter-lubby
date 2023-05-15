import 'package:flutter/widgets.dart';

import 'package:lubby_app/src/config/routes/routes.dart';
import 'package:lubby_app/src/domain/entities/finances/account_entity.dart';
import 'package:lubby_app/src/domain/entities/finances/transaction_entity.dart';

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
