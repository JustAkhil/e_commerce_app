import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/helper/api_helper.dart';
import '../../../data/models/get_order_model.dart';
import '../../../domain/constants/app_urls.dart';
import 'get_order_event.dart';
import 'get_order_state.dart';

class GetOrderBloc extends Bloc<GetOrderEvent, GetOrderState> {
  final ApiHelper apiHelper;

  GetOrderBloc({required this.apiHelper}) : super(GetOrderInitialState()) {
    on<GetAllOrderEvent>((event, emit) async {
      try {
        emit(GetOrderLoadingState());
        dynamic data = await apiHelper.getApi(url: AppUrls.getOrder);

        if (data != null && data["status"] == true) {
          GetOrderModel orderModel = GetOrderModel.fromJson(data);
          emit(GetOrderLoadedState(mOrders: orderModel.orders ?? []));
        } else {
          emit(GetOrderErrorState(data["message"] ?? "Unknown error"));
        }
      } catch (e) {
        emit(GetOrderErrorState(e.toString()));
      }
    });
  }
}