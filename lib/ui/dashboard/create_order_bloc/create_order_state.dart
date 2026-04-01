abstract class CreateOrderState{

}
class CreateOrderInitialState extends CreateOrderState{}
class CreateOrderLoadingState extends CreateOrderState{}
class CreateOrderSuccessState extends CreateOrderState{

}
class CreateOrderErrorState extends CreateOrderState{
  String errMsg;
  CreateOrderErrorState({required this.errMsg});
}