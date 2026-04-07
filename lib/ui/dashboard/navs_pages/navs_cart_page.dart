import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:e_commerce_app/ui/dashboard/create_order_bloc/create_order_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart-fetchbloc/get_cart_bloc.dart';
import '../cart-fetchbloc/get_cart_event.dart';
import '../cart-fetchbloc/get_cart_state.dart';
import '../create_order_bloc/create_order_bloc.dart';
import '../create_order_bloc/create_order_state.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoading=false;
  var discountCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GetCartBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Cart",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, AppRoutes.dashboard),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: BlocBuilder<GetCartBloc, GetCartState>(
        builder: (context, state) {
          if (state is GetCartLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orangeAccent),
            );
          }
          if (state is GetCartErrorState) {
            return Center(
              child: Text(
                "No Item Added Yet..",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (state is GetCartLoadedState) {
            final cartList = state.mCartList;
            if (cartList!.isEmpty) {
              return Center(
                child: Text(
                  "Cart is empty",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }
            double subTotal = 0;

            for (var item in cartList) {
              double price = double.tryParse(item.price.toString()) ?? 0;
              int quantity = int.tryParse(item.quantity.toString()) ?? 1;

              subTotal += price * quantity;
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartList.length,
                    padding: EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final item = cartList[index];

                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: NetworkImage(item.image ?? ""),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name ?? "",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Mobile",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "₹${item.price}",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.orange,
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${item.quantity}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 10),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: discountCodeController,
                    cursorColor: Colors.orange,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      fillColor: Color(0xFF1F1F1F),
                      filled: true,
                      hintText: "Enter Discount Code",
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.discount, color: Colors.orange),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(15),
                      suffixIcon: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Apply",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "₹${subTotal.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "₹${subTotal.toStringAsFixed(2)}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Color(0xFF1F1F1F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    color: Colors.orange,
                                    size: 50,
                                  ),

                                  SizedBox(height: 15),
                                  Text(
                                    "Confirm Order",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                  Text(
                                    "Are you sure you want to place this order?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                  SizedBox(height: 25),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 10),
                                      Expanded(
                                        child: BlocConsumer<CreateOrderBloc,CreateOrderState>(
                                          listener: (context, state) {
                                            if (state is CreateOrderLoadingState) {
                                              isLoading = true;
                                              setState(() {});
                                            }
                                            if (state is CreateOrderErrorState) {
                                              isLoading = false;
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    state.errMsg,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  backgroundColor: Color(
                                                    0xFF1F1F1F,
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 8,
                                                ),
                                              );
                                            }
                                            if (state is CreateOrderSuccessState) {
                                              isLoading = false;
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.viewOrder,
                                              );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Order Place Successfully",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  backgroundColor: Color(
                                                    0xFFFF7A00,
                                                  ),
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  margin: EdgeInsets.all(10),
                                                  elevation: 8,
                                                ),
                                              );
                                              Navigator.pushReplacementNamed(
                                                context,
                                                AppRoutes.dashboard,
                                              );
                                            }
                                          },
                                          builder: (context, state) {
                                            return InkWell(
                                              onTap: () {
                                                context
                                                    .read<CreateOrderBloc>()
                                                    .add(PlaceOrderEvent());
                                              },
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.orange,
                                                      Colors.deepOrange,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Confirm",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },

                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orange, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
