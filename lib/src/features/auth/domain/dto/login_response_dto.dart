import '../../../user/domain/entities/user_entity.dart';

class LoginResponseDTO {
  final String accessToken;
  final String refreshToken;
  final UserEntity user;

  LoginResponseDTO({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) {
    return LoginResponseDTO(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: UserEntity.fromMap(json['user']),
    );
  }
}
