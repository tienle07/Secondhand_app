/// id : "1ab73f1f-f254-4367-addc-d44b4fa0204f"
/// title : "dsad"
/// like : false
/// description : "Tủ lạnh"
/// img : [{"url":"https://firebasestorage.googleapis.com/v0/b/secondhandvh-44c3e.appspot.com/o/images%2Fb3f10c87-ea30-4b80-8f22-922670c5cdab?alt=media&token=ac37e77f-4d4d-41d0-9a02-3ca3601110a7"},{"url":"https://firebasestorage.googleapis.com/v0/b/secondhandvh-44c3e.appspot.com/o/images%2Fc348c0d2-cbfd-4970-be11-1c226870a110?alt=media&token=f15a27f1-15c7-4a8b-8c17-101e0484fdd7"},{"url":"https://firebasestorage.googleapis.com/v0/b/secondhandvh-44c3e.appspot.com/o/images%2F9c05c0b9-4327-43e5-918a-3db96f4fe980?alt=media&token=a2b9a4d0-e829-431d-816f-3afa9fef099c"},{"url":"https://firebasestorage.googleapis.com/v0/b/secondhandvh-44c3e.appspot.com/o/images%2F690904cb-423f-437b-9b6c-a05ae02f0549?alt=media&token=be523802-703b-4f8f-b3b6-3fdec94f0757"}]
/// category : {"categoryName":"Đồ gia dụng","attribute":"Chua ro"}
/// product : [{"productName":"Tủ lạnh","price":"100000"}]

class Post {
  Post({
      String? id, 
      String? title, 
      bool? like, 
      String? description, 
      List<Img>? img, 
      Category? category, 
      List<Product>? product,}){
    _id = id;
    _title = title;
    _like = like;
    _description = description;
    _img = img;
    _category = category;
    _product = product;
}

  Post.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _like = json['like'];
    _description = json['description'];
    if (json['img'] != null) {
      _img = [];
      json['img'].forEach((v) {
        _img?.add(Img.fromJson(v));
      });
    }
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['product'] != null) {
      _product = [];
      json['product'].forEach((v) {
        _product?.add(Product.fromJson(v));
      });
    }
  }
  String? _id;
  String? _title;
  bool? _like;
  String? _description;
  List<Img>? _img;
  Category? _category;
  List<Product>? _product;
Post copyWith({  String? id,
  String? title,
  bool? like,
  String? description,
  List<Img>? img,
  Category? category,
  List<Product>? product,
}) => Post(  id: id ?? _id,
  title: title ?? _title,
  like: like ?? _like,
  description: description ?? _description,
  img: img ?? _img,
  category: category ?? _category,
  product: product ?? _product,
);
  String? get id => _id;
  String? get title => _title;
  bool? get like => _like;
  String? get description => _description;
  List<Img>? get img => _img;
  Category? get category => _category;
  List<Product>? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['like'] = _like;
    map['description'] = _description;
    if (_img != null) {
      map['img'] = _img?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// productName : "Tủ lạnh"
/// price : "100000"

class Product {
  Product({
      String? productName, 
      String? price,}){
    _productName = productName;
    _price = price;
}

  Product.fromJson(dynamic json) {
    _productName = json['productName'];
    _price = json['price'];
  }
  String? _productName;
  String? _price;
Product copyWith({  String? productName,
  String? price,
}) => Product(  productName: productName ?? _productName,
  price: price ?? _price,
);
  String? get productName => _productName;
  String? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = _productName;
    map['price'] = _price;
    return map;
  }

}

/// categoryName : "Đồ gia dụng"
/// attribute : "Chua ro"

class Category {
  Category({
      String? categoryName, 
      String? attribute,}){
    _categoryName = categoryName;
    _attribute = attribute;
}

  Category.fromJson(dynamic json) {
    _categoryName = json['categoryName'];
    _attribute = json['attribute'];
  }
  String? _categoryName;
  String? _attribute;
Category copyWith({  String? categoryName,
  String? attribute,
}) => Category(  categoryName: categoryName ?? _categoryName,
  attribute: attribute ?? _attribute,
);
  String? get categoryName => _categoryName;
  String? get attribute => _attribute;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryName'] = _categoryName;
    map['attribute'] = _attribute;
    return map;
  }

}

/// url : "https://firebasestorage.googleapis.com/v0/b/secondhandvh-44c3e.appspot.com/o/images%2Fb3f10c87-ea30-4b80-8f22-922670c5cdab?alt=media&token=ac37e77f-4d4d-41d0-9a02-3ca3601110a7"

class Img {
  Img({
      String? url,}){
    _url = url;
}

  Img.fromJson(dynamic json) {
    _url = json['url'];
  }
  String? _url;
Img copyWith({  String? url,
}) => Img(  url: url ?? _url,
);
  String? get url => _url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    return map;
  }

}