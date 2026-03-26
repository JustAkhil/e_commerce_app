import 'package:e_commerce_app/data/models/cart_fetch_model.dart';

abstract class GetCartState{}
class GetCartInitialState extends GetCartState{
}
class GetCartLoadingState extends GetCartState{}
class GetCartLoadedState extends GetCartState{
  List<CartDataModel>?mCartList;
  GetCartLoadedState({required this.mCartList});
}
class GetCartErrorState extends GetCartState{
  String errMsg;
  GetCartErrorState({required this.errMsg});
}