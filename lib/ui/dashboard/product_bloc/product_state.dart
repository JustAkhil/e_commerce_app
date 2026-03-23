import 'package:e_commerce_app/data/models/product_model.dart';

abstract class ProductState{}
class ProductInitialState extends ProductState{}
class ProductLoadingState extends ProductState{}
class ProductSuccessState extends ProductState{
  List<ProductModel>mProductList;
  ProductSuccessState({required this.mProductList});
}
class ProductErrorState extends ProductState{
  String errMsg;
  ProductErrorState({required this.errMsg});
}