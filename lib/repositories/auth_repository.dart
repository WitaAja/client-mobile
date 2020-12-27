import 'package:dio/dio.dart';
import 'package:wisata_aja/models/auth_model.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/utils/api_client/api_client.dart';

class AuthRepositories {
  Future<AuthResponse> login({String email,String fullName,String name,String urlPhoto}) async {
    FormData formData =
        new FormData.fromMap({"name": name, "fullname": fullName, "email": email, "foto": urlPhoto});
    Response response = await sl.get<ApiClient>().dio.post('/users/login', data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      return AuthResponse.fromJson(response.data);
    }
    throw Exception("failed login");
  }
}
