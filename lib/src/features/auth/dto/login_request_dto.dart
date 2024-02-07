import 'package:equatable/equatable.dart';

class LoginRequestDTO extends Equatable {
  final String email;
  final String password;

  const LoginRequestDTO({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  factory LoginRequestDTO.fromJson(Map<String, dynamic> json) =>
      LoginRequestDTO(
        email: json['email'],
        password: json['password'],
      );

  @override
  List<Object?> get props => [email, password];

  @override
  bool? get stringify => true;
}
