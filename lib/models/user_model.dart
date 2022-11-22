class UserModel {
  int id;
  String uuid;
  int sub;
  String email;
  String nombre;
  String apellidos;
  String createdAt;
  String? picUrl;

  UserModel({
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
    return ({
      "id": id,
      "uuid": uuid,
      "sub": sub,
      "email": email,
      "nombre": nombre,
      "apellidos": apellidos,
      "createdAt": createdAt,
      "picUrl": picUrl ?? '',
    });
  }

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
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
