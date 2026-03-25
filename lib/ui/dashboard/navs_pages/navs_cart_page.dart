import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Cart"),
        leading: CircleAvatar(
          child: IconButton(onPressed: (){
            Navigator.pushNamed(context, AppRoutes.dashboard);
          },icon:Icon(Icons.arrow_back_ios_new)),
        ),
      ),
    );
  }
}