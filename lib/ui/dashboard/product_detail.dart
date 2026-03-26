import 'package:dots_indicator/dots_indicator.dart';
import 'package:e_commerce_app/data/models/product_model.dart';
import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_bloc.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_event.dart';
import 'package:e_commerce_app/ui/dashboard/cart-bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productdetail extends StatefulWidget {
  @override
  State<Productdetail> createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  ProductModel? productModels;

  int dotIndex = 0;

  int quant = 1;

  bool isLoading = false;
  bool isProductAdded = false;


  @override
  Widget build(BuildContext context) {
    productModels = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 60, left: 15, right: 15),
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Color(0xFF1C1C1C),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    productModels!.image ?? "",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    children: [
                      _iconBtn(Icons.arrow_back_ios_new, () {
                        Navigator.pop(context);
                      }),

                      Spacer(),

                      _iconBtn(Icons.share, () {}),

                      SizedBox(width: 10),

                      _iconBtn(Icons.favorite_border, () {}),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: DotsIndicator(
                    dotsCount: 3,
                    position: dotIndex.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: Color(0xFFFF7A00),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 15),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          productModels!.name ?? "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "₹${productModels!.price ?? ""}",
                        style: TextStyle(
                          color: Color(0xFFFF7A00),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.star, color: Color(0xFFFF7A00), size: 18),
                      SizedBox(width: 5),
                      Text("4.2", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 10),
                      Text(
                        "(320 Reviews)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Premium quality product designed for modern users. Comfortable, stylish, and long-lasting.",
                    style: TextStyle(color: Colors.grey, height: 1.5),
                  ),

                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _feature(Icons.local_shipping, "Free Delivery"),
                      _feature(Icons.verified, "Original"),
                      _feature(Icons.refresh, "Return"),
                    ],
                  ),

                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 75,
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatefulBuilder(
                builder: (context, ss) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quant > 1) {
                              quant--;
                              ss(() {});
                            }
                          },
                          icon: Icon(Icons.remove, color: Colors.white)),
                        Text(
                          "$quant",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {
                            quant++;
                            ss(() {});
                          },
                          icon: Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                },
              ),
              BlocConsumer<AddToCartBloc, AddToCartState>(
                listenWhen: (ps,cs)=>!isProductAdded,
                listener: (context, state) {
                  if (state is AddToCartErrorState) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errMsg,
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFFFF7A00),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.all(10),
                        elevation: 8,
                      ),
                    );
                  }
                  if (state is AddToCartLoadingState) {
                    isLoading = true;
                  }
                  if (state is AddToCartSuccessState) {
                    isProductAdded = true;
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Product Added Successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFFFF7A00),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.all(10),
                        elevation: 8,
                      ),

                    );
                    Navigator.pushNamed(context,AppRoutes.cart);

                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed :() {
                        context.read<AddToCartBloc>().add(
                          AddToCartEvent(
                            productId: int.parse(productModels!.id!),
                            quantity: quant,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFff650e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                              trackGap: 2,
                              strokeWidth: 2,
                            )
                          : Text(
                              "Add To Cart",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _feature(IconData icon, String text) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Color(0xFFFF7A00)),
        ),
        SizedBox(height: 5),
        Text(text, style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }
}
