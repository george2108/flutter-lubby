import 'package:flutter/widgets.dart';
import 'package:lubby_app/src/data/entities/label_entity.dart';
import 'package:lubby_app/src/domain/entities/finances/account_abstract_entity.dart';

class AccountEntity extends AccountAbstractEntity {
  const AccountEntity({
    super.id,
    super.labelId,
    super.label,
    super.description,
    required super.name,
    required super.balance,
    required super.createdAt,
    required super.icon,
    required super.color,
  });

  factory AccountEntity.fromMap(Map<String, dynamic> json) {
    return AccountEntity(
      id: json['id'],
      labelId: json['labelId'],
      label: LabelEntity.fromMap(json['label']),
      name: json['name'],
      description: json['description'],
      balance: json['balance'],
      createdAt: DateTime.parse(json['createdAt']),
      icon: IconData(json['icon'], fontFamily: 'MaterialIcons'),
      color: Color(int.parse('0xFF${json["color"]}')),
    );
  }

  String colorToString() {
    return color.value.toRadixString(16);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "labelId": labelId,
      "name": name,
      "description": description,
      "balance": balance,
      "createdAt": createdAt.toString(),
      "icon": icon.codePoint,
      "color": colorToString(),
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
        labelId: labelId ?? this.labelId,
        label: label ?? this.label,
        name: name ?? this.name,
        description: description ?? this.description,
        balance: balance ?? this.balance,
        createdAt: createdAt ?? this.createdAt,
        icon: icon ?? this.icon,
        color: color ?? this.color,
      );
}
