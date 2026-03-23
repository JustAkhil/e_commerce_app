import 'package:e_commerce_app/data/helper/api_helper.dart';
import 'package:e_commerce_app/domain/constants/app_urls.dart';
import 'package:e_commerce_app/ui/on_boarding/bloc/user_event.dart';
import 'package:e_commerce_app/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiHelper apiHelper;

  UserBloc({required this.apiHelper}) : super(InitialUserState()) {
    on<SignUpUserEvent>((event, emit) async{
      emit(LoadingUserState());
      try {
        dynamic data=await  apiHelper.postApi(url: AppUrls.signUpUrl,details:{
          "name":event.name,
          "mobile_number":event.mobNo,
          "email":event.email,
          "password":event.pass
        },isAuth: true);
        if(data["status"]){
          /// if user direct navigate to dashboard page after creating account then provide token here
          /// but after create a account then navigate to login
          /// after login through login page then provide token in login page
          emit(SuccessUserState());
        }else{
          emit(ErrorUserState(msg: data["message"]));
        }
      } catch (e) {
        emit(ErrorUserState(msg: e.toString()));
      }
    });
    on<LoginUserEvent>((event,emit)async{
      emit(LoadingUserState());
      try{
        dynamic data=await apiHelper.postApi(url: AppUrls.loginUrl,details: {

          "email":event.email,
          "password":event.pass
        },isAuth: true);
        //is auth true hoga to post api me token wla kaam nhi hoga
        if(data["status"]){
          emit(SuccessUserState());
          //store token in shared preference
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setString("token", data["tokan"]);
        }else{
          emit(ErrorUserState(msg: data["message"]));
        }
      }catch(e){
        emit(ErrorUserState(msg: e.toString()));
      }
    });

  }
}