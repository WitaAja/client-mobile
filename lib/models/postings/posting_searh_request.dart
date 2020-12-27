class PostingSearchRequest {
  String prov;
  String kota;
  List<String> category;

  PostingSearchRequest({this.prov, this.kota, this.category});

  PostingSearchRequest.fromJson(Map<String, dynamic> json) {
    prov = json['prov'];
    kota = json['kota'];
    category = json['category'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prov'] = this.prov;
    data['kota'] = this.kota;
    data['category'] = this.category;
    return data;
  }
}