// class DropdownItem {
//   String? id;
//   String? categoryName;
//
//   DropdownItem({required this.id, required this.categoryName});
//
//   factory DropdownItem.fromJson(Map<String, dynamic> json) {
//     return DropdownItem(
//         id: json['id'],
//         categoryName: json['categoryName']
//     );
//   }
// }

class DropdownItem {
  String? id;
  String? categoryName;

  DropdownItem({this.id, this.categoryName});

  factory DropdownItem.fromJson(Map<String, dynamic> json) {
    return DropdownItem(
      id: json["id"],
      categoryName: json["categoryName"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["categoryName"] = categoryName;
    return data;
  }
}

