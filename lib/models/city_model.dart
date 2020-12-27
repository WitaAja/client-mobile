class City {
  bool status;
  int code;
  String message;
  List<CityDetail> data;

  City({this.status, this.code, this.message, this.data});

  City.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CityDetail>();
      json['data'].forEach((v) {
        data.add(new CityDetail.fromJson(v));
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
}

class CityDetail {
  String id;
  String provinsiId;
  String name;

  CityDetail({this.id, this.provinsiId, this.name});

  CityDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinsiId = json['provinsi_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['provinsi_id'] = this.provinsiId;
    data['name'] = this.name;
    return data;
  }
}
