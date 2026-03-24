import 'package:e_commerce_app/domain/constants/app_urls.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_event.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/helper/api_helper.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  ApiHelper apiHelper;

  AddToCartBloc({required this.apiHelper}) : super(AddToCartInitialState()) {
    on<AddToCartEvent>((event,emit)async{
      emit(AddToCartLoadingState());
      try{
        dynamic data=await apiHelper.postApi(url: AppUrls.addToCart,details: {
          "product_id":event.productId,
          "quantity":event.quantity
        });
        if(data["status"]){
          emit(AddToCartSuccessState());
        }else{
          emit(AddToCartErrorState(errMsg: data["message"]));
        }
      }catch(e){
        emit(AddToCartErrorState(errMsg: e.toString()));
      }
    });
  }
}
