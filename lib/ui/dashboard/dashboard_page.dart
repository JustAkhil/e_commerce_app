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

  List<Widget> mNavs = [
    MenuPage(),
    FavPage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  int selectedPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    bool isHomeSelect = selectedPageIndex == 2;

    return Scaffold(
      backgroundColor: Color(0xFF0F0F0F),

      body: mNavs[selectedPageIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isHomeSelect
              ? LinearGradient(
            colors: [Colors.orange, Colors.deepOrange],
          )
              : LinearGradient(
            colors: [Colors.orange.shade400,Colors.orange.shade900],
          ),
          boxShadow: isHomeSelect
              ? [
            BoxShadow(
              color: Colors.orange.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 3,
            )
          ]
              : [],
        ),
        child: FloatingActionButton(
          onPressed: () {
            selectedPageIndex = 2;
            setState(() {});
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.home_filled, size: 34, color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.black12,
        elevation: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _navItem(Icons.menu, 0),
              _navItem(Icons.favorite_outline, 1),
              SizedBox(width: 30),
              _navItem(Icons.shopping_cart_outlined, 3),
              _navItem(Icons.person_outline, 4),
            ],
          ),
        ),
      ),
    );
  }
  Widget _navItem(IconData icon, int index) {
    bool isSelected = selectedPageIndex == index;

    return GestureDetector(
      onTap: () {
        selectedPageIndex = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.orange.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 2,
            )
          ]
              : [],
        ),
        child: Icon(
          icon,
          size: 30,
          color: isSelected ? Colors.orange : Colors.grey,
        ),
      ),
    );
  }
}