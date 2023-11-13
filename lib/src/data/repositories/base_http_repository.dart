import 'package:dio/dio.dart';
import 'dart:io';

import '../../core/resources/data_state.dart';

abstract class BaseHttpRepository {
  Future<DataState<T>> getStateOf<T>({
    required Future<Response<T>> Function() request,
  }) async {
    try {
      final response = await request();
      print(response);
      if (response.statusCode == HttpStatus.ok) {
        return DataSuccess(response.data as T);
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
