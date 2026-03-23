class CategoryModel {
  String? created_at;
  String? updated_at;
  String? name;
  String? id;
  String? status;

  CategoryModel({
    required this.name,
    required this.id,
    required this.status,
    required this.created_at,
    required this.updated_at,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json["name"],
      id: json["id"],
      status: json["status"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = name;
    data["id"] = id;
    data["status"] = status;
    data["created_at"] = created_at;
    data["updated_at"] = updated_at;
    return data;
  }
}

class DataCatModel {
  String? message;
  bool? status;
  List<CategoryModel> data;

  DataCatModel({
    required this.message,
    required this.status,
    required this.data,
  });

  factory DataCatModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonCat = json["data"];
    List<CategoryModel> mCat = [];
    for (Map<String, dynamic> eachMap in jsonCat) {
      CategoryModel eachCatModel = CategoryModel.fromJson(eachMap);
      mCat.add(eachCatModel);
    }
    return DataCatModel(
      message: json["message"],
      status: json["status"],
      data: mCat
    );
  }
}
