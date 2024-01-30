import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import 'http_service.dart';

class SyncServerService {
  final Connectivity _connectivity = Connectivity();
  final HttpService httpService;

  SyncServerService({required this.httpService});

  Future<Response<dynamic>?> syncElements(dynamic data, String path) async {
    final connStatus = await _connectivity.checkConnectivity();

    if (connStatus == ConnectivityResult.mobile ||
        connStatus == ConnectivityResult.wifi ||
        connStatus == ConnectivityResult.ethernet) {
      final response = await httpService.post(
        path: path,
        data: data,
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw DioException(
          response: response,
          requestOptions: response.requestOptions,
        );
      }

      return response;
    }

    return null;
  }
}
