import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String uuid;
  final bool active;
  final String createdAt;
  final String email;
  final String firstName;
  final String lastName;
  final String? picUrl;

  const UserEntity({
    required this.id,
    required this.uuid,
    required this.active,
    required this.createdAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.picUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'active': active,
      'createdAt': createdAt,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'picUrl': picUrl,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        id: json['id'] as int,
        uuid: json['uuid'] as String,
        active: json['active'] as bool,
        createdAt: json['createdAt'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        picUrl: json['picUrl'] as String?,
      );

  UserEntity copyWith({
    int? id,
    String? uuid,
    bool? active,
    String? createdAt,
    String? email,
    String? firstName,
    String? lastName,
    String? picUrl,
  }) {
    return UserEntity(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      picUrl: picUrl ?? this.picUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        active,
        createdAt,
        email,
        firstName,
        lastName,
        picUrl,
      ];
}
