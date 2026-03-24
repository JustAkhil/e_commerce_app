abstract class AddToCartState{}
class AddToCartInitialState extends AddToCartState{}
class AddToCartLoadingState extends AddToCartState{}
class AddToCartSuccessState extends AddToCartState{}
class AddToCartErrorState extends AddToCartState{
  String errMsg;
  AddToCartErrorState({required this.errMsg});
}
