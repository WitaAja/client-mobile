import 'package:dio/dio.dart';
import 'package:wisata_aja/models/category_model.dart';
import 'package:wisata_aja/models/city_model.dart';
import 'package:wisata_aja/models/province_model.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/utils/api_client/api_client.dart';

class RegionRepositories {
  Future<Province> loadProvince() async {
    Response response = await sl.get<ApiClient>().dio.get('/wilayah/provinsi/');
    if (response.statusCode == 200) {
      return Province.fromJson(response.data);
    } else {
      throw Exception("failed load province");
    }
  }

  Future<City> loadCity({String id}) async {
    Response response = await sl.get<ApiClient>().dio.get('/wilayah/kota/$id/');
    if (response.statusCode == 200) {
      print(response.data);
      return City.fromJson(response.data);
    } else {
      throw Exception("failed load city");
    }
  }

  Future<CategoryModel> loadCategory() async {
    Response response = await sl.get<ApiClient>().dio.get('/wilayah/category');
    if (response.statusCode == 200) {
      return CategoryModel.fromJson(response.data);
    } else {
      throw Exception("failed load city");
    }
  }
}
