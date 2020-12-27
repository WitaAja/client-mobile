import 'package:dio/dio.dart';

abstract class Middleware {
  Future<void> apply(Dio dio);
}

class CacheMiddleware extends Middleware {
  String apiUrl;
  Duration cacheMaxAge;
  CacheMiddleware({this.apiUrl, this.cacheMaxAge}) {
    cacheMaxAge = cacheMaxAge ?? Duration(seconds: 20);
  }

  @override
  Future<void> apply(Dio dio) {
  }
}
