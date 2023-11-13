import 'package:dio/dio.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../data/datasources/remote/http_service.dart';
import '../../domain/dto/login_request_dto.dart';
import '../../domain/dto/login_response_dto.dart';
import '../../domain/repositories/login_repository_abstract.dart';

class LoginRepository implements LoginRepositoryAbstract {
  final HttpService httpService;

  LoginRepository({required this.httpService});

  @override
  Future<DataState<LoginResponseDTO>> login(LoginRequestDTO data) async {
    try {
      final response = await httpService.post(
        path: '/auth/login',
        data: data.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = LoginResponseDTO.fromJson(response.data);
        return DataSuccess(data);
      } else {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }
    } on DioException catch (error) {
      return DataError(error);
    }
  }
}
