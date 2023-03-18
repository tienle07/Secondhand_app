/// id : "1"
/// CategoryName : "Do gia dung"

class CategoryModel {
  CategoryModel({
      String? id,
      String? categoryName,}){
    _id = id;
    _categoryName = categoryName;
}

  CategoryModel.fromJson(dynamic json) {
    _id = json['id'];
    _categoryName = json['CategoryName'];
  }
  String? _id;
  String? _categoryName;
CategoryModel copyWith({  String? id,
  String? categoryName,
}) => CategoryModel(  id: id ?? _id,
  categoryName: categoryName ?? _categoryName,
);
  String? get id => _id;
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['CategoryName'] = _categoryName;
    return map;
  }

}