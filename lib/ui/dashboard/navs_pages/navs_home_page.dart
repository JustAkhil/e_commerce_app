import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_event.dart';
import 'package:e_commerce_app/ui/dashboard/cat_bloc/cat_state.dart';
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
  }
  TextEditingController searchController = TextEditingController();
  List<String> bannerList = [
    "https://cdn.dribbble.com/userupload/40919812/file/original-4f7e1642391fa9692fb72e494d4e764a.jpg?resize=1504x1253&vertical=center",
    "https://cdn.dribbble.com/userupload/37639814/file/original-ee7289f1da3287676c2e799cf4ca5dac.jpg?resize=1504x1128&vertical=center",
    "https://cdn.dribbble.com/userupload/32284207/file/original-db79ff539dc14852f44ba89d667f0066.jpg?resize=1504x1128&vertical=center",
    "https://cdn.dribbble.com/userupload/33017833/file/original-57ecaf8f737689524aaece536e7769dd.jpg?resize=752x&vertical=center",
  ];
  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFf6f6f6),
                      foregroundColor: Colors.black,
                      radius: 30,
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            Navigator.pushNamed(context, AppRoutes.login);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("token", "");
                          },
                          icon: Icon(Icons.more_horiz_rounded, size: 40),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFf6f6f6),
                      foregroundColor: Colors.black,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.black26),
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "|",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black26,
                            ),
                          ),
                          SizedBox(width: 4),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.menu_open_sharp,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.black26),
                      filled: true,
                      fillColor: Color(0xFFf6f6f6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      CarouselSlider.builder(
                        itemCount: bannerList.length,
                        itemBuilder: (_, index, _) {
                          return Container(
                            margin: EdgeInsetsGeometry.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(bannerList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          onPageChanged: (index, _) {
                            setState(() {
                              dotIndex = index;
                            });
                          },
                          animateToClosest: true,
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(
                            milliseconds: 500,
                          ),
                          autoPlayInterval: Duration(seconds: 3),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                      ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        left: 1,
                        child: DotsIndicator(
                          position: dotIndex.toDouble(),
                          dotsCount: bannerList.length,
                          animate: true,
                          decorator: DotsDecorator(
                            activeColor: Colors.orangeAccent,
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(51),
                              side: BorderSide(color: Colors.orange.shade900),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(51),
                              side: BorderSide(color: Colors.orange.shade900),
                            ),
                            color: Colors.transparent,
                            activeSize: Size(16, 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                BlocBuilder<CatBloc, CatState>(
                  builder: (_, state) {
                    if (state is CatLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is CatErrorState) {
                      return Center(child: Text(state.errMsg));
                    }

                    if (state is CatSuccessState) {
                      return SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.mCatList.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(bannerList[3]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Text(state.mCatList[index].name ?? "")
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
