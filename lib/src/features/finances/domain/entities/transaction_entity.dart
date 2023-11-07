import 'package:equatable/equatable.dart';
import 'package:lubby_app/src/features/labels/domain/entities/label_entity.dart';

import 'account_entity.dart';

class TransactionEntity extends Equatable {
  final int? id;
  final int accountId;
  final AccountEntity account;
  final int? accountDestId;
  final AccountEntity? accountDest;
  final String title;
  final String? description;
  final double amount;
  final DateTime createdAt;
  final String type;
  final LabelEntity? label;
  final int? labelId;

  const TransactionEntity({
    this.id,
    required this.accountId,
    required this.account,
    required this.title,
    this.description,
    required this.amount,
    required this.createdAt,
    required this.type,
    this.label,
    this.labelId,
    this.accountDestId,
    this.accountDest,
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
      label:
          json['labelId'] != null ? LabelEntity.fromMap(json['label']) : null,
      labelId: json['labelId'],
      accountDestId: json['accountDestId'],
      accountDest: json['accountDestId'] != null
          ? AccountEntity.fromMap(json['accountDest'])
          : null,
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
      "labelId": labelId,
      "accountDestId": accountDestId,
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
    LabelEntity? label,
    int? labelId,
    int? accountDestId,
    AccountEntity? accountDest,
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
        label: label ?? this.label,
        labelId: labelId ?? this.labelId,
        accountDestId: accountDestId ?? this.accountDestId,
        accountDest: accountDest ?? this.accountDest,
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
        label,
        labelId,
        accountDestId,
        accountDest,
      ];
}
