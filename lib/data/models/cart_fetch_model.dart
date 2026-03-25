class CartDataModel {
  int? id;
  int? product_id;
  String? image;
  String? name;
  String? price;
  int? quantity;

  CartDataModel({
    required this.id,
    required this.product_id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json["id"] ?? 0,
      product_id: json["product_id"] ?? 0,
      image: json["image"] ?? "",
      name: json["name"] ?? "",
      price: json["price"] ?? "",
      quantity: json["quantity"] ?? 0,
    );
  }
}

class CartModel {
  bool status;
  String message;
  List<CartDataModel>? data;

  CartModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    List<CartDataModel> mCart = [];
    for (Map<String, dynamic> eachCart in (json["data"] ?? [])) {
      mCart.add(CartDataModel.fromJson(eachCart));
    }
    return CartModel(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
      data: mCart,
    );
  }
}