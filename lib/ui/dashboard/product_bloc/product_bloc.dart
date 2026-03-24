import 'package:e_commerce_app/data/helper/api_helper.dart';
import 'package:e_commerce_app/ui/dashboard/product_bloc/product_event.dart';
import 'package:e_commerce_app/ui/dashboard/product_bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/constants/app_urls.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ApiHelper apiHelper;

  ProductBloc({required this.apiHelper}) : super(ProductInitialState()) {
    on<GetProductEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token") ?? "";
        dynamic data = await apiHelper.postApi(
          url: AppUrls.productUrl,
          mHeaders: {"Authorization": "Bearer $token"},
        );
        if (data != null && data["status"] == true) {
          ProductDataModel productDataModel = ProductDataModel.fromJson(data);
          emit(ProductSuccessState(mProductList: productDataModel.data!));
        } else {
          emit(ProductErrorState(errMsg: data["message"]));
        }
      } catch (e) {
        emit(ProductErrorState(errMsg: e.toString()));
      }
    });
  }
}
