import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String uuid;
  final int sub;
  final String email;
  final String nombre;
  final String apellidos;
  final String createdAt;
  final String? picUrl;

  const User({
    required this.id,
    required this.uuid,
    required this.sub,
    required this.email,
    required this.nombre,
    required this.apellidos,
    required this.createdAt,
    this.picUrl,
  });

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

  @override
  bool? get stringify => true;
}
