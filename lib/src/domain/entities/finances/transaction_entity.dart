import 'package:equatable/equatable.dart';

import 'account_entity.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final int accountId;
  final AccountEntity account;
  final String title;
  final String? description;
  final double amount;
  final DateTime createdAt;
  final String type;

  const TransactionEntity({
    this.id,
    required this.accountId,
    required this.account,
    required this.title,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.type,
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
}
