import 'package:e_commerce_app/ui/dashboard/dashboard_page.dart';
import 'package:e_commerce_app/ui/dashboard/navs_pages/navs_cart_page.dart';
import 'package:e_commerce_app/ui/on_boarding/login/login_page.dart';
import 'package:e_commerce_app/ui/on_boarding/signup/sign_up_page.dart';
import 'package:e_commerce_app/ui/splash/splash.dart';
import 'package:flutter/widgets.dart';

import '../../ui/dashboard/navs_pages/navs_fav_page.dart';
import '../../ui/dashboard/navs_pages/navs_menu_page.dart';
import '../../ui/dashboard/navs_pages/navs_profile_page.dart';
import '../../ui/dashboard/product_detail.dart';
import '../../ui/dashboard/view_order_page.dart';

class AppRoutes {
  static final splash = "/";
  static final login = "/login";
  static final signUp = "/signUp";
  static final dashboard = "/dashboard";
  static final productDetail = "/productDetail";
  static final cart = "/cart";
  static final fav = "/fav";
  static final profile = "/profile";
  static final menu = "/menu";
  static final viewOrder="view-order";


  static Map<String, WidgetBuilder> getRoutes() =>
      {
        splash: (context) => SplashPage(),
        login: (context) => LoginPage(),
        signUp: (context) => SignUpPage(),
        dashboard: (context) => DashBoard(),
        productDetail: (context) => Productdetail(),
        cart: (context) => CartPage(),
        fav: (context) => FavPage(),
        profile: (context) => ProfilePage(),
        menu: (context) => MenuPage(),
        viewOrder: (context) => ViewOrderPage(),


      };
}