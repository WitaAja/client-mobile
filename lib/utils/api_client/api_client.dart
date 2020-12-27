import 'package:dio/dio.dart';
import 'package:wisata_aja/utils/constant.dart';
import 'afterware.dart';
import 'middleware.dart';

Dio dio = Dio();

class ApiClient {
  Dio dio;
  static int initializedToken;
  List<AfterWare> afterWares = [];
  List<Middleware> middleWares = [];

  Future<RequestOptions> onRequest(RequestOptions options) async {
    var customHeaders = {
      'content-type': 'application/json',
    };
    options.headers.addAll(customHeaders);
    return options;
  }

  ApiClient({this.afterWares, this.middleWares}) {
    dio = Dio(BaseOptions(baseUrl: API_URL, connectTimeout: 10000, sendTimeout: 10000));
    for (Middleware _middleWare in this.middleWares) {
      _middleWare.apply(dio);
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: this.onRequest,
        onResponse: (Response response) async {
          try {
            for (AfterWare _afterWare in this.afterWares) {
              _afterWare.apply(response);
            }
            return response;
          } catch (e) {}
          return response;
        },
        onError: (DioError e) async {
          return e; //continue
        },
      ),
    );
  }

  void setToken(String token) {
    if (initializedToken != null) {
      return;
    }
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      options.headers["authorization"] = "Bearer $token";
      return options; //continue
    }));

    initializedToken = dio.interceptors.length - 1;
  }

  void updateToken(String token) {
    removeToken();
    setToken(token);
  }

  void removeToken() {
    if (initializedToken == null) {
      return;
    }
    dio.interceptors.removeAt(initializedToken);
    initializedToken = null;
  }
}
