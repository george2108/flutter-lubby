import 'package:lubby_app/src/domain/entities/user_abstract_entity.dart';

class UserEntity extends UserAbstractEntity {
  const UserEntity({
    required id,
    required uuid,
    required sub,
    required email,
    required nombre,
    required apellidos,
    required createdAt,
    picUrl,
  }) : super(
          id: id,
          uuid: uuid,
          sub: sub,
          email: email,
          nombre: nombre,
          apellidos: apellidos,
          createdAt: createdAt,
          picUrl: picUrl,
        );

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
}
