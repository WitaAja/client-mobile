import 'package:dio/dio.dart';

abstract class AfterWare {
  Future<void> apply(Response response);
}

class TokenExpiredAfterWare extends AfterWare {
  apply(Response response) async {
    if (response.data is Map) {
    }
  }
}

class ResponseErrorDialogAfterWare extends AfterWare {
  @override
  apply(Response response) async {

  }
}
