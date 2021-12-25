class RegisterModel {
  String email;
  String password;
  String nombre;
  String? apellidos;
  String? telefono;

  RegisterModel({
    required this.email,
    required this.password,
    required this.nombre,
    this.apellidos,
    this.telefono,
  });

  Map<String, dynamic> toMap() {
    return ({
      "email": this.email,
      "password": this.password,
      "nombre": this.nombre,
      "apellidos": this.apellidos ?? '',
      "telefono": this.telefono ?? '',
    });
  }

  factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
        email: json["email"],
        password: json["password"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        telefono: json["telefono"],
      );
}
