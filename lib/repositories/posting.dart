import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:wisata_aja/models/postings/posting_searh_request.dart';
import 'package:wisata_aja/models/postings/postings_model.dart';
import 'package:wisata_aja/models/status_model.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:wisata_aja/services/service_locator.dart';
import 'package:wisata_aja/utils/api_client/api_client.dart';

class PostingRepositories {
  Future<Status> uploads({List<Asset> files, String desc, String prov, String city, List<String> category}) async {
    Future<List<MapEntry<String, MultipartFile>>> listImages() async {
      List<MapEntry<String, MultipartFile>> newFile = [];
      for (var i = 0; i < files.length; i++) {
        ByteData byteData = await files[i].getByteData();
        List<int> imageData = byteData.buffer.asUint8List();
        newFile.add(MapEntry(
            "photos",
            MultipartFile.fromBytes(
              imageData,
              filename: files[i].name,
              contentType: MediaType("images", "jpg"),
            )));
      }
      return newFile;
    }
    var formData = FormData();

    void listCategory() {
      for (int i = 0; i < category.length; i++) {
        formData.fields.add(MapEntry("category", category[i]));
      }
    }

    formData.fields.add(MapEntry("description", desc));
    formData.fields.add(MapEntry("prov", prov));
    formData.fields.add(MapEntry("kota", city));
    listCategory();
    formData.files.addAll(await listImages());

    Response response = await sl.get<ApiClient>().dio.post('/posting/', data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      return Status.fromJson(response.data);
    } else {
      throw Exception("failed upload");
    }
  }

  Future<Posting> loadPostings() async {
    Response response = await sl.get<ApiClient>().dio.get('/posting/');
    print(response.data);
    if (response.statusCode == 200) {
      return Posting.fromJson(response.data);
    }
    throw Exception("failed login");
  }

  Future<Posting> loadMyPostings() async {
    Response response = await sl.get<ApiClient>().dio.get('/posting/my-posting');
    print(response.data);
    if (response.statusCode == 200) {
      return Posting.fromJson(response.data);
    }
    throw Exception("failed login");
  }

  Future<Posting> loadPostingSearch({PostingSearchRequest postingSearchRequest}) async {
    Response response = await sl.get<ApiClient>().dio.post('/posting/posting-search',data: postingSearchRequest.toJson());
    print(response.data);
    if (response.statusCode == 200) {
      return Posting.fromJson(response.data);
    }
    throw Exception("failed login");
  }

}
