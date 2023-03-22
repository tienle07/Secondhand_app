class PostModel {
  PostModel({
      String? msg, 
      List<Post>? post,}){
    _msg = msg;
    _post = post;
}

  PostModel.fromJson(dynamic json) {
    _msg = json['msg'];
    if (json['post'] != null) {
      _post = [];
      json['post'].forEach((v) {
        _post?.add(Post.fromJson(v));
      });
    }
  }
  String? _msg;
  List<Post>? _post;
PostModel copyWith({  String? msg,
  List<Post>? post,
}) => PostModel(  msg: msg ?? _msg,
  post: post ?? _post,
);
  String? get msg => _msg;
  List<Post>? get post => _post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    if (_post != null) {
      map['post'] = _post?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}


class Post {
  Post({
      String? id, 
      String? title, 
      bool? like, 
      String? description, 
      String? userId,
      List<Img>? img, 
      List<Product>? product,}){
    _id = id;
    _title = title;
    _like = like;
    _description = description;
    _userId = userId;
    _img = img;
    _product = product;
}

  Post.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _like = json['like'];
    _description = json['description'];
    _userId = json['userId'];
    if (json['img'] != null) {
      _img = [];
      json['img'].forEach((v) {
        _img?.add(Img.fromJson(v));
      });
    }
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
  String? _userId;
  List<Img>? _img;
  List<Product>? _product;
Post copyWith({  String? id,
  String? title,
  bool? like,
  String? description,
  String? userId,
  List<Img>? img,
  List<Product>? product,
}) => Post(  id: id ?? _id,
  title: title ?? _title,
  like: like ?? _like,
  description: description ?? _description,
  userId: userId ?? _userId,
  img: img ?? _img,
  product: product ?? _product,
);
  String? get id => _id;
  String? get title => _title;
  bool? get like => _like;
  String? get description => _description;
  String? get userId => _userId;
  List<Img>? get img => _img;
  List<Product>? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['like'] = _like;
    map['description'] = _description;
    map['userId'] = _userId;
    if (_img != null) {
      map['img'] = _img?.map((v) => v.toJson()).toList();
    }
    if (_product != null) {
      map['product'] = _product?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class Product {
  Product({
      String? productName, 
      String? price, 
      bool? status, 
      Category? category,}){
    _productName = productName;
    _price = price;
    _status = status;
    _category = category;
}

  Product.fromJson(dynamic json) {
    _productName = json['productName'];
    _price = json['price'];
    _status = json['status'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }
  String? _productName;
  String? _price;
  bool? _status;
  Category? _category;
Product copyWith({  String? productName,
  String? price,
  bool? status,
  Category? category,
}) => Product(  productName: productName ?? _productName,
  price: price ?? _price,
  status: status ?? _status,
  category: category ?? _category,
);
  String? get productName => _productName;
  String? get price => _price;
  bool? get status => _status;
  Category? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = _productName;
    map['price'] = _price;
    map['status'] = _status;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }

}



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