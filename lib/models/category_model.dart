import 'package:flutter/material.dart';
import 'package:wisata_aja/colors.dart';
import 'package:wisata_aja/utils/random_number.dart';

class CategoryModel {
  bool status;
  int code;
  String message;
  List<Category> data;

  CategoryModel({this.status, this.code, this.message, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Category>();
      json['data'].forEach((v) {
        data.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static Color get getColorCategory {
    return colorCategory[RandomNumber.getRandomNumber];
  }

  List<String> getCheckBox(List<Category> listCategory) {
    try {
      final newData = listCategory.where((element) => element.valuePost == true).toList();
      final newString = newData.map((e) => e.id).toList();
      return newString;
    } catch (_) {
      return [];
    }
  }

  Category getById(String id) {
    try {
      final newData = data.where((element) => element.id == id);

      if (newData.isEmpty) {
        return null;
      }
      return newData.first;
    } catch (_) {
      return null;
    }
  }

  static bool isExist(List<String> listCategoryId,String id) {
    try {
      final value = listCategoryId.where((element) => id == element);
      return value.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

}

class Category {
  String id;
  String name;
  bool valueFilterSearch;
  bool valuePost;

  Category({this.id, this.name, this.valueFilterSearch = false, this.valuePost = false});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    valueFilterSearch = false;
    valuePost = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
