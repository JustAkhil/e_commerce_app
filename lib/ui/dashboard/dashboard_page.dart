import 'package:e_commerce_app/ui/dashboard/navs_pages/navs_fav_page.dart';
import 'package:e_commerce_app/ui/dashboard/navs_pages/navs_menu_page.dart';
import 'package:flutter/material.dart';

import 'navs_pages/navs_cart_page.dart';
import 'navs_pages/navs_home_page.dart';
import 'navs_pages/navs_profile_page.dart';

class DashBoard extends StatefulWidget {
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget>mNavs=[
    MenuPage(),
    FavPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];
  int selectedPageIndex=2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mNavs[selectedPageIndex],

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrangeAccent.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 4,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            selectedPageIndex=2;
            setState(() {

            });
          },
          elevation: 10,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
          child: Icon(
            Icons.home_filled,
            size: 42,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                selectedPageIndex=0;
                setState(() {

                });
              },
              icon: Icon(Icons.menu, size: 32, color: Colors.black26),
            ),
            IconButton(
              onPressed: () {
                selectedPageIndex=1;
                setState(() {

                });
              },
              icon: Icon(Icons.favorite_outline, size: 32, color: Colors.black26),
            ),
            SizedBox(width: 50),
            IconButton(
              onPressed: () {
                selectedPageIndex=3;
                setState(() {

                });
              },
              icon: Icon(Icons.shopping_cart_outlined, size: 32, color: Colors.black26),
            ),
            IconButton(
              onPressed: () {
                selectedPageIndex=4;
                setState(() {

                });
              },
              icon: Icon(Icons.person_outline, size: 32, color: Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}