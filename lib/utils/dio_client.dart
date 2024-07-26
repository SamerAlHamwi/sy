

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/io.dart';

class DioClient {
  static Dio getDio() {
    Dio dio = Dio();

    // Create a custom HttpClient with badCertificateCallback
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final HttpClient client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }
}
