class Profile {
  bool status;
  int code;
  String message;
  Data data;

  Profile({this.status, this.code, this.message, this.data});

  Profile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  String name;
  String fullname;
  String email;
  String about;
  String foto;

  Data({this.id, this.name, this.fullname, this.email, this.about, this.foto});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullname = json['fullname'];
    email = json['email'];
    about = json['about'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['about'] = this.about;
    data['foto'] = this.foto;
    return data;
  }
}


class ProfileRequest {
  String name;
  String fullname;
  String about;
  String foto;

  ProfileRequest({this.name, this.fullname, this.about, this.foto});

  ProfileRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fullname = json['fullname'];
    about = json['about'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['fullname'] = this.fullname;
    data['about'] = this.about;
    data['foto'] = this.foto;
    return data;
  }
}
