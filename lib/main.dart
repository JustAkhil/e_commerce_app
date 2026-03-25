import 'package:e_commerce_app/data/helper/api_helper.dart';
import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_bloc.dart';
import 'package:e_commerce_app/ui/dashboard/cart-fetchbloc/get_cart_bloc.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_bloc.dart';
import 'package:e_commerce_app/ui/dashboard/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/ui/on_boarding/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context)=>UserBloc(apiHelper: ApiHelper())),
      BlocProvider(create: (context)=>CatBloc(apiHelper: ApiHelper(),)),
      BlocProvider(create: (context)=>ProductBloc(apiHelper: ApiHelper())),
      BlocProvider(create: (context)=>AddToCartBloc(apiHelper: ApiHelper())),
      BlocProvider(create: (context)=>GetCartBloc(apiHelper: ApiHelper()))
    ],
    child: MyApp(),));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
    );
  }
}