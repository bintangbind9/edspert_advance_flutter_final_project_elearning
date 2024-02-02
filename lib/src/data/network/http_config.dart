import 'package:dio/dio.dart';

import '../../common/constants/urls.dart';

class HttpConfig {
  static Dio dioConfig() {
    final dio = Dio();

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.baseUrl = Urls.baseUrl;
        options.headers = {'x-api-key': Urls.apiKey};
        handler.next(options);
      },
      onError: (error, handler) {
        handler.next(error);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
    ));

    return dio;
  }
}
