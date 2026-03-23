import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_event.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_state.dart';
import 'package:e_commerce_app/ui/dashboard/product_bloc/product_bloc.dart';
import 'package:e_commerce_app/ui/dashboard/product_bloc/product_event.dart';
import 'package:e_commerce_app/ui/dashboard/product_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cat_bloc/cat_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    context.read<CatBloc>().add(GetCatEvent());
    context.read<ProductBloc>().add(GetProductEvent());
  }

  TextEditingController searchController = TextEditingController();

  List<String> bannerList = [
    "https://cdn.dribbble.com/userupload/40919812/file/original-4f7e1642391fa9692fb72e494d4e764a.jpg",
    "https://cdn.dribbble.com/userupload/37639814/file/original-ee7289f1da3287676c2e799cf4ca5dac.jpg",
    "https://cdn.dribbble.com/userupload/32284207/file/original-db79ff539dc14852f44ba89d667f0066.jpg",
  ];

  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleBtn(Icons.menu, () async {
                      Navigator.pushNamed(context, AppRoutes.login);
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      prefs.setString("token", "");
                    }),
                    _circleBtn(Icons.notifications_none, () {}),
                  ],
                ),

                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    cursorColor: Colors.orange,
                    controller: searchController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search, color: Colors.orange),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: bannerList.length,
                      itemBuilder: (_, index, __) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            bannerList[index],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 1,
                        onPageChanged: (i, _) {
                          setState(() => dotIndex = i);
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: DotsIndicator(
                        dotsCount: bannerList.length,
                        position: dotIndex.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: Colors.orange,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),
                BlocBuilder<CatBloc, CatState>(
                  builder: (_, state) {
                    if (state is CatLoadingState) {
                      return CircularProgressIndicator(color: Colors.orange);
                    }

                    if (state is CatSuccessState) {
                      return SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.mCatList.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1F1F1F),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.category,
                                        color: Colors.orange),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    state.mCatList[index].name ?? "",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return SizedBox();
                  },
                ),

                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Special For You",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(color: Colors.orange),
                    )
                  ],
                ),

                SizedBox(height: 10),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (_, state) {

                    if (state is ProductLoadingState) {
                      return Container();
                    }

                    if (state is ProductSuccessState) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.mProductList.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (_, index) {

                          var product = state.mProductList[index];

                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.productDetail,
                                    arguments: state.mProductList[index]
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1F1F1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                        child: Image.network(
                                          product.image ?? "",
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.contain,
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name ?? "",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              "₹${product.price}",
                                              style: TextStyle(
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right:0.1,
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Icon(Icons.favorite_border,
                                      color: Colors.white, size: 25),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _circleBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1F1F1F),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white),
      ),
    );
  }
}