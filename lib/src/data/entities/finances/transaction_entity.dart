import 'package:lubby_app/src/domain/entities/finances/transaction_abstract_entity.dart';

import 'account_entity.dart';

class TransactionEntity extends TransactionAbstractEntity {
  const TransactionEntity({
    super.id,
    super.description,
    required super.accountId,
    required super.account,
    required super.title,
    required super.amount,
    required super.createdAt,
    required super.type,
  });

  factory TransactionEntity.fromMap(Map<String, dynamic> json) {
    return TransactionEntity(
      id: json['id'],
      accountId: json['accountId'],
      account: AccountEntity.fromMap(json['account']),
      title: json['title'],
      description: json['description'],
      amount: json['amount'],
      createdAt: DateTime.parse(json['createdAt']),
      type: json['type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "accountId": accountId,
      "title": title,
      "description": description,
      "amount": amount,
      "createdAt": createdAt.toString(),
      "type": type,
    };
  }

  TransactionEntity copyWith({
    int? id,
    int? accountId,
    AccountEntity? account,
    String? title,
    String? description,
    double? amount,
    DateTime? createdAt,
    String? type,
  }) =>
      TransactionEntity(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        account: account ?? this.account,
        title: title ?? this.title,
        description: description ?? this.description,
        amount: amount ?? this.amount,
        createdAt: createdAt ?? this.createdAt,
        type: type ?? this.type,
      );
}
