import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../../labels/domain/entities/label_entity.dart';

class AccountEntity extends Equatable {
  final int? id;
  final String? description;
  final String name;
  final double balance;
  final DateTime createdAt;
  final IconData icon;
  final Color color;

  const AccountEntity({
    this.id,
    this.description,
    required this.name,
    required this.balance,
    required this.createdAt,
    required this.icon,
    required this.color,
  });

  factory AccountEntity.fromMap(Map<String, dynamic> json) {
    return AccountEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      balance: json['balance'],
      createdAt: DateTime.parse(json['createdAt']),
      icon: IconData(int.parse(json['icon']), fontFamily: 'MaterialIcons'),
      color: Color(json["color"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "balance": balance,
      "createdAt": createdAt.toString(),
      "icon": icon.codePoint,
      "color": color.value,
    };
  }

  AccountEntity copyWith({
    int? id,
    int? labelId,
    LabelEntity? label,
    String? name,
    String? description,
    double? balance,
    DateTime? createdAt,
    IconData? icon,
    Color? color,
  }) =>
      AccountEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        balance: balance ?? this.balance,
        createdAt: createdAt ?? this.createdAt,
        icon: icon ?? this.icon,
        color: color ?? this.color,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        balance,
        createdAt,
        icon,
        color,
      ];
}
