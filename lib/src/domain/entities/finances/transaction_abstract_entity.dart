import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/data/entities/finances/account_entity.dart';

abstract class TransactionAbstractEntity extends Equatable {
  final int? id;
  final int accountId;
  final AccountEntity account;
  final String title;
  final String? description;
  final double amount;
  final DateTime createdAt;
  final String type;

  const TransactionAbstractEntity({
    this.id,
    required this.accountId,
    required this.account,
    required this.title,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.type,
  });

  @override
  List<Object?> get props => [
        id,
        accountId,
        account,
        title,
        description,
        amount,
        createdAt,
        type,
      ];

  @override
  bool? get stringify => true;
}
