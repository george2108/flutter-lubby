import 'package:dio/dio.dart';

import '../../../core/resources/data_state.dart';
import '../../../data/datasources/remote/http_service.dart';
import '../dto/register_request_dto.dart';
import '../dto/register_response_dto.dart';
import 'register_repository_abstract.dart';

class RegisterRepository implements RegisterRepositoryAbstract {
  final HttpService httpService;

  RegisterRepository({required this.httpService});

  @override
  Future<DataState<RegisterResponseDTO>> register(
    RegisterRequestDTO data,
  ) async {
    try {
      final response = await httpService.post(
        path: '/auth/register',
        data: data.toJson(),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = RegisterResponseDTO.fromJson(response.data);
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
