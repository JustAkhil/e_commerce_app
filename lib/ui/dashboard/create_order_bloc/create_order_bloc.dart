import 'package:e_commerce_app/data/helper/api_helper.dart';
import 'package:e_commerce_app/domain/constants/app_urls.dart';
import 'package:e_commerce_app/ui/dashboard/create_order_bloc/create_order_event.dart';
import 'package:e_commerce_app/ui/dashboard/create_order_bloc/create_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateOrderBloc extends Bloc<CreateOrderEvent,CreateOrderState>{
  ApiHelper apiHelper;
  CreateOrderBloc({required this.apiHelper}):super(CreateOrderInitialState()){
    on<PlaceOrderEvent>((event,emit)async{
      emit(CreateOrderLoadingState());
      try{
        dynamic data=await apiHelper.postApi(url: AppUrls.createOrder);
        if(data['status']){
          emit(CreateOrderSuccessState());
        }else{
          emit(CreateOrderErrorState(errMsg: data['message']));
        }
      }catch(e){
        emit(CreateOrderErrorState(errMsg: e.toString()));
      }
    });
  }
}