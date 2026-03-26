import '../../../data/models/get_order_model.dart';

abstract class GetOrderState{}
class GetOrderInitialState extends GetOrderState{

}
class GetOrderLoadingState extends GetOrderState{

}
class GetOrderLoadedState extends GetOrderState{
  List<Orders>mOrders=[];
  GetOrderLoadedState({required this.mOrders});
}
class GetOrderErrorState extends GetOrderState{
  final String errMsg;

  GetOrderErrorState(this.errMsg);
}