class Auth {
  final String token;
  const Auth({this.token});
}

class AuthResponse {
  bool status;
  int code;
  String message;
  Data data;

  AuthResponse({this.status, this.code, this.message, this.data});

  AuthResponse.fromJson(Map<String, dynamic> json) {
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
  String userId;
  String email;
  String token;

  Data({this.userId, this.email, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}