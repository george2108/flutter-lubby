import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user_entity.dart';

class RegisterResponseDTO extends Equatable {
  final String accessToken;
  final UserEntity user;

  const RegisterResponseDTO({
    required this.accessToken,
    required this.user,
  });

  factory RegisterResponseDTO.fromJson(Map<String, dynamic> json) {
    return RegisterResponseDTO(
      accessToken: json['accessToken'] as String,
      user: UserEntity.fromMap(json['user'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [accessToken, user];
}
