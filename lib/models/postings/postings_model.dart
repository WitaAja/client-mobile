class Posting {
  bool status;
  int code;
  String message;
  List<PostingModel> data;

  Posting({this.status, this.code, this.message, this.data});

  Posting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<PostingModel>();
      json['data'].forEach((v) {
        data.add(new PostingModel.fromJson(v));
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

class PostingModel {
  String id;
  String description;
  String prov;
  String kota;
  String createdBy;
  String createdAt;
  String updatedAt;
  User user;
  AsProvinsi asProvinsi;
  AsProvinsi asKota;
  List<Imageposts> imageposts;
  List<PostCategory> postCategory;

  PostingModel(
      {this.id,
        this.description,
        this.prov,
        this.kota,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.user,
        this.asProvinsi,
        this.asKota,
        this.imageposts,
        this.postCategory});

  PostingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    prov = json['prov'];
    kota = json['kota'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    asProvinsi = json['as_provinsi'] != null
        ? new AsProvinsi.fromJson(json['as_provinsi'])
        : null;
    asKota = json['as_kota'] != null
        ? new AsProvinsi.fromJson(json['as_kota'])
        : null;
    if (json['imageposts'] != null) {
      imageposts = new List<Imageposts>();
      json['imageposts'].forEach((v) {
        imageposts.add(new Imageposts.fromJson(v));
      });
    }
    if (json['post_category'] != null) {
      postCategory = new List<PostCategory>();
      json['post_category'].forEach((v) {
        postCategory.add(new PostCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['prov'] = this.prov;
    data['kota'] = this.kota;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.asProvinsi != null) {
      data['as_provinsi'] = this.asProvinsi.toJson();
    }
    if (this.asKota != null) {
      data['as_kota'] = this.asKota.toJson();
    }
    if (this.imageposts != null) {
      data['imageposts'] = this.imageposts.map((v) => v.toJson()).toList();
    }
    if (this.postCategory != null) {
      data['post_category'] = this.postCategory.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String id;
  String name;
  String foto;

  User({this.id, this.name, this.foto});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['foto'] = this.foto;
    return data;
  }
}

class AsProvinsi {
  String id;
  String name;

  AsProvinsi({this.id, this.name});

  AsProvinsi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Imageposts {
  String id;
  String urlImg;

  Imageposts({this.id, this.urlImg});

  Imageposts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urlImg = json['urlImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['urlImg'] = this.urlImg;
    return data;
  }
}

class PostCategory {
  String id;
  String categoryId;
  AsProvinsi asCategory;

  PostCategory({this.id, this.categoryId, this.asCategory});

  PostCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    asCategory = json['as_category'] != null
        ? new AsProvinsi.fromJson(json['as_category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    if (this.asCategory != null) {
      data['as_category'] = this.asCategory.toJson();
    }
    return data;
  }
}