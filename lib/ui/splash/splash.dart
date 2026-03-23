import 'dart:async';
import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")??"";
      String nextPage=AppRoutes.login;
      if(token.isNotEmpty){
        nextPage=AppRoutes.dashboard;
      }
      Navigator.pushReplacementNamed(context, nextPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF111111),
              Color(0xFF1F1F1F),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 15,
                    offset: Offset(0, 20),
                  ),
                ],
              ),
              child: Image.asset(
                "assets/logo/logo.png",
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.02),
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFFFF7A00),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}