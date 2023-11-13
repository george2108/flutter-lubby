import '../../../../data/datasources/remote/http_service.dart';

class AuthService {
  final HttpService httpService;

  AuthService({required this.httpService});

  /* Future<Response<RegisterResponseDTO>> register() async {
    final response = await httpService.post(path: '/users');
    final data = RegisterResponseDTO.fromJson(response.data);
    response.data = data;
    return response;
  } */
}
