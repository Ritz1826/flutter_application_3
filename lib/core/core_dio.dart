import 'package:dio/dio.dart';

class CoreDio {
  late Dio dio;

  static final CoreDio _instance = CoreDio._internal();

  factory CoreDio() {
    return _instance;
  }

  CoreDio._internal() {
    final baseOptions = BaseOptions(
      baseUrl: "",
      connectTimeout: Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      receiveTimeout: Duration(microseconds: 0),
    );

    dio = Dio(baseOptions);
  }

  Future<Response> postApi(String apiUrl, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(apiUrl, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
