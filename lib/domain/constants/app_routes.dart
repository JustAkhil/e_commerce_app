import 'package:e_commerce_app/ui/dashboard/dashboard_page.dart';
import 'package:e_commerce_app/ui/on_boarding/login/login_page.dart';
import 'package:e_commerce_app/ui/on_boarding/signup/sign_up_page.dart';
import 'package:e_commerce_app/ui/splash/splash.dart';
import 'package:flutter/widgets.dart';

class AppRoutes{
  static final splash="/";
  static final login="/login";
  static final signUp="/signUp";
  static final dashboard="/dashboard";

  static Map<String,WidgetBuilder>getRoutes()=>{
    splash :(context)=>SplashPage(),
    login:(context)=>LoginPage(),
    signUp:(context)=>SignUpPage(),
    dashboard:(context)=>DashBoard(),
  };
}