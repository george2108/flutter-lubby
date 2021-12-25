import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:lubby_app/models/user_model.dart';
import 'package:lubby_app/services/shared_preferences_service.dart';
import 'package:lubby_app/widgets/show_snackbar_widget.dart';

class HttpService {
  late Dio _dio;

  // android
  // necesita configuracion en androidManifest.xml
  // <application
  //       android:usesCleartextTraffic="true"
  final baseUrl = 'http://10.0.2.2:3000/api/v1';
  // final baseUrl = 'http://jorge.xst.mx/api/v1/';

  //ios
  // final baseUrl = 'http://127.0.0.1:3000/api/v1/';

  late SharedPreferencesService sharedPreferences;

  HttpService() {
    sharedPreferences = Get.find<SharedPreferencesService>();
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        // esta opcion es para que en codigos de respuesta como 401 no tire la app
        validateStatus: (i) => true,
      ),
    );
    initializeIterceptors();
    print(_dio);
  }

  initializeIterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          return handler.next(error);
        },
        onRequest: (request, handler) {
          if (sharedPreferences.token != '') {
            request.headers = {
              'Authorization': 'Bearer ${sharedPreferences.token}'
            };
          }
          return handler.next(request);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            showSnackBarWidget(
              title: 'Algo salió mal',
              message: 'No estas autorizado',
              type: TypeSnackbar.error,
            );
          } else if (response.statusCode! > 400) {
            showSnackBarWidget(
              title: 'Algo salió mal',
              message: response.data['message'],
              type: TypeSnackbar.error,
            );
          }
          if (response.data['access_token'] != null) {
            sharedPreferences.token = response.data['access_token'];
          }
          if (response.data['identity'] != null) {
            final userModel = response.data['identity'];
            final userJson = jsonEncode(userModel);
            sharedPreferences.user = userJson;
          }
          return handler.next(response);
        },
      ),
    );
  }

  Future<Response> getRequest(String url) async {
    return await _dio.get(url);
  }

  Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return await _dio.post(url, data: data);
  }

  Future<Response> putRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return await _dio.put(url, data: data ?? {});
  }

  Future<Response> deleteRequest(String endpoint) async {
    return await _dio.get(endpoint);
  }
}
