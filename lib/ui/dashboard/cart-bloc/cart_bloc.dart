  import 'package:e_commerce_app/domain/constants/app_urls.dart';
  import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_event.dart';
  import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_state.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';

  import '../../../data/helper/api_helper.dart';

  class AddToCartBloc extends Bloc<CartEvent, AddToCartState> {
    ApiHelper apiHelper;

    AddToCartBloc({required this.apiHelper}) : super(AddToCartInitialState()) {
      on<AddToCartEvent>((event,emit)async{
        emit(AddToCartLoadingState());
        try{
          dynamic data=await apiHelper.postApi(url: AppUrls.addToCart,details: {
            "product_id":event.productId,
            "quantity":event.quantity
          });
          if(data!=null && data["status"]==true){
            emit(AddToCartSuccessState());
            emit(AddToCartInitialState());
          }else{
            emit(AddToCartErrorState(errMsg: data["message"]));

          }
        }catch(e){
          emit(AddToCartErrorState(errMsg: e.toString()));
        }
      });
      on<DecrementCartEvent>((event,emit)async{
        emit(AddToCartLoadingState());
        try{
          dynamic data=await apiHelper.postApi(url: AppUrls.decrementCart,details: {
            "product_id":event.productId,
            "quantity":event.quantity,
          });
            if(data!=null && data["status"]==true){
              emit(AddToCartSuccessState());
            }else{
              emit(AddToCartErrorState(errMsg: data["message"]??"Something Went Wrong "));
            }
        }catch (e){
          emit(AddToCartErrorState(errMsg: e.toString()));
        }
      });
    }
  }
