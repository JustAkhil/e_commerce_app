import 'package:e_commerce_app/domain/constants/app_urls.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_event.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/helper/api_helper.dart';

class AddToCartBloc extends Bloc<CartEvent, AddToCartState> {
  ApiHelper apiHelper;

  AddToCartBloc({required this.apiHelper}) : super(AddToCartInitialState()) {
    on<AddToCartEvent>((event, emit) async {
      emit(AddToCartLoadingState());
      try {
        dynamic data = await apiHelper.postApi(
          url: AppUrls.addToCart,
          details: {
            "product_id": event.productId,
            "quantity": event.quantity,
          },
        );

        // ✅ handles bool true, string "true", and int 1
        bool isSuccess = data != null &&
            (data["status"] == true ||
                data["status"].toString().toLowerCase() == "true" ||
                data["status"] == 1);

        if (isSuccess) {
          emit(AddToCartSuccessState());
        } else {
          emit(AddToCartErrorState(
            errMsg: data["message"]?.toString() ?? "Something went wrong",
          ));
        }
      } catch (e) {
        emit(AddToCartErrorState(errMsg: e.toString()));
      }
    });

    on<DecrementCartEvent>((event, emit) async {
      emit(AddToCartLoadingState());
      try {
        dynamic data = await apiHelper.postApi(
          url: AppUrls.decrementCart,
          details: {
            "product_id": event.productId,
            "quantity": event.quantity,
          },
        );

        bool isSuccess = data != null &&
            (data["status"] == true ||
                data["status"].toString().toLowerCase() == "true" ||
                data["status"] == 1);

        if (isSuccess) {
          emit(AddToCartSuccessState());
        } else {
          emit(AddToCartErrorState(
            errMsg: data["message"]?.toString() ?? "Something went wrong",
          ));
        }
      } catch (e) {
        emit(AddToCartErrorState(errMsg: e.toString()));
      }
    });
  }
}