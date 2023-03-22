class NewPost {
  String? title;
  String? description;
  String? userId;
  String? productName;
  String? price;
  String? categoryId;
  List<ImgIds>? imgIds;

  NewPost({this.title, this.description, this.userId, this.productName, this.price, this.categoryId, this.imgIds});

  NewPost.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    description = json["description"];
    userId = json["userId"];
    productName = json["productName"];
    price = json["price"];
    categoryId = json["categoryId"];
    imgIds = json["imgIds"] == null ? null : (json["imgIds"] as List).map((e) => ImgIds.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["title"] = title;
    _data["description"] = description;
    _data["userId"] = userId;
    _data["productName"] = productName;
    _data["price"] = price;
    _data["categoryId"] = categoryId;
    if(imgIds != null) {
      _data["imgIds"] = imgIds?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ImgIds {
  String? url;

  ImgIds({this.url});

  ImgIds.fromJson(Map<String, dynamic> json) {
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    return _data;
  }
}