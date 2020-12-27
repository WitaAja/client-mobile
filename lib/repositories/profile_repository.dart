import 'package:dio/dio.dart';
import 'package:wisata_aja/models/profile_model.dart';
import 'package:wisata_aja/models/status_model.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/utils/api_client/api_client.dart';

class ProfileRepositories {
  Future<Profile> loadMyProfile() async {
    Response response = await sl.get<ApiClient>().dio.get('/profile/');
    print(response.data);
    if (response.statusCode == 200) {
      return Profile.fromJson(response.data);
    }
    throw Exception("failed login");
  }

  Future<Status> editMyProfile(ProfileRequest profileRequest) async {
    Response response = await sl.get<ApiClient>().dio.put('/profile/', data: profileRequest.toJson());
    print(response.data);
    if (response.statusCode == 200) {
      return Status.fromJson(response.data);
    }
    throw Exception("failed login");
  }
}
