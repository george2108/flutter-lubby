import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String uuid;
  final int sub;
  final String email;
  final String nombre;
  final String apellidos;
  final String createdAt;
  final String? picUrl;

  const UserEntity({
    required this.id,
    required this.uuid,
    required this.sub,
    required this.email,
    required this.nombre,
    required this.apellidos,
    required this.createdAt,
    this.picUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "uuid": uuid,
      "sub": sub,
      "email": email,
      "nombre": nombre,
      "apellidos": apellidos,
      "createdAt": createdAt,
      "picUrl": picUrl ?? '',
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> json) => UserEntity(
        id: json["id"],
        uuid: json["uuid"],
        sub: json["sub"],
        email: json["email"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        createdAt: json["createdAt"],
        picUrl: json["picUrl"],
      );

  UserEntity copyWith({
    int? id,
    String? uuid,
    int? sub,
    String? email,
    String? nombre,
    String? apellidos,
    String? createdAt,
    String? picUrl,
  }) =>
      UserEntity(
        id: id ?? this.id,
        uuid: uuid ?? this.uuid,
        sub: sub ?? this.sub,
        email: email ?? this.email,
        nombre: nombre ?? this.nombre,
        apellidos: apellidos ?? this.apellidos,
        createdAt: createdAt ?? this.createdAt,
        picUrl: picUrl ?? this.picUrl,
      );

  @override
  List<Object?> get props => [
        id,
        uuid,
        sub,
        email,
        nombre,
        apellidos,
        createdAt,
        picUrl,
      ];
}
