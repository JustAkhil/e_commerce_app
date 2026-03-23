import 'package:e_commerce_app/data/helper/api_helper.dart';
import 'package:e_commerce_app/data/models/cat_model.dart';
import 'package:e_commerce_app/domain/constants/app_urls.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_event.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatBloc extends Bloc<CatEvent, CatState> {
  ApiHelper apiHelper;

  CatBloc({required this.apiHelper}) : super(CatInitialState()) {
    on<GetCatEvent>((event, emit) async {
      emit(CatLoadingState());
      try {
        dynamic res = await apiHelper.getApi(url: AppUrls.catUrl);
        if (res["status"]) {
          DataCatModel dataCatModel=DataCatModel.fromJson(res);
          emit(CatSuccessState(mCatList: dataCatModel.data));
        } else {
          emit(CatErrorState(errMsg: res["message"]));
        }
      } catch (e) {
        emit(CatErrorState(errMsg: e.toString()));
      }
    });
  }
}

