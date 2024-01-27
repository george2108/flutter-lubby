import 'package:dio/dio.dart';

import '../../../../injector.dart';
import '../../../core/constants/http_constants.dart';
import '../local/services/shared_preferences_service.dart';

class HttpService {
  late final Dio dio;

  HttpService() {
    dio = createDio();
  }

  createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: kBaseUrl,
        receiveTimeout: const Duration(milliseconds: 1500),
        connectTimeout: const Duration(milliseconds: 1500),
        sendTimeout: const Duration(milliseconds: 15000),
      ),
    );

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }

  Future<Response<dynamic>> post({
    required String path,
    dynamic data,
  }) async {
    return dio.post(path, data: data);
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final sharedPreferences = injector.get<SharedPreferencesService>();
    final accessToken = sharedPreferences.token;

    if (accessToken.isNotEmpty) {
      // options.headers['Authorization'] = 'Bearer $accessToken';
      options.headers.addAll({
        "Authorization": "Bearer $accessToken",
      });
    }

    super.onRequest(options, handler);
  }
}
