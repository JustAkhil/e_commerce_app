class GetOrderModel {
  bool? status;
  String? message;
  List<Orders>? orders;

  GetOrderModel({this.status, this.message, this.orders});

  GetOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  final int? id;
  final String? totalAmount;
  final String? orderNumber;
  final String? status;
  final String? createdAt;
  final List<Product>? product;

  Orders({this.id, this.totalAmount, this.orderNumber, this.status, this.createdAt, this.product});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      totalAmount: json['total_amount'],
      orderNumber: json['order_number'],
      status: json['status'],
      createdAt: json['created_at'],
      product: json['product'] != null
          ? List<Product>.from(json['product'].map((x) => Product.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'total_amount': totalAmount,
    'order_number': orderNumber,
    'status': status,
    'created_at': createdAt,
    'product': product?.map((x) => x.toJson()).toList(),
  };
}

class Product {
  int? id;
  String? name;
  int? quantity;
  String? price;
  String? image;

  Product({this.id, this.name, this.quantity, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}