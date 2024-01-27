import 'package:equatable/equatable.dart';

class RegisterRequestDTO extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const RegisterRequestDTO({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      };

  factory RegisterRequestDTO.fromJson(Map<String, dynamic> json) =>
      RegisterRequestDTO(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
      );

  @override
  List<Object?> get props => [firstName, lastName, email, password];

  @override
  bool? get stringify => true;
}
