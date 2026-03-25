import 'package:e_commerce_app/data/helper/api_helper.dart';
import 'package:e_commerce_app/data/models/cart_fetch_model.dart';
import 'package:e_commerce_app/domain/constants/app_urls.dart';
import 'package:e_commerce_app/ui/dashboard/cart-fetchbloc/get_cart_event.dart';
import 'package:e_commerce_app/ui/dashboard/cart-fetchbloc/get_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetCartBloc extends Bloc<GetCartEvent,GetCartState>{
  ApiHelper apiHelper;
  GetCartBloc({required this.apiHelper}):super(GetCartInitialState()){
    on<FetchCartEvent>((event,emit)async{
      emit(GetCartLoadingState());
     try{
       dynamic data=await apiHelper.getApi(url: AppUrls.viewCart,);
       if(data !=null && data["status"]==true){
         CartModel cartModel=CartModel.fromJson(data);
         emit(GetCartLoadedState(mCartList: cartModel.data!));
       }else{
         emit(GetCartErrorState(errMsg: data["message"]));
       }
     }catch(e){
       emit(GetCartErrorState(errMsg: e.toString()));
     }
    });
  }
}