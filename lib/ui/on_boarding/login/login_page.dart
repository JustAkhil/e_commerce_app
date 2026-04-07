import 'package:e_commerce_app/domain/constants/app_routes.dart';
import 'package:e_commerce_app/ui/on_boarding/bloc/user_bloc.dart';
import 'package:e_commerce_app/ui/on_boarding/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_state.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isPassHidden = true;
  bool isLoading = false;
  bool isLogin = true;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 25),
                    TextFormField(
                      controller: emailController,
                      cursorColor: Color(0xFFFF7A00),
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        RegExp emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );

                        if (value == null || value.isEmpty) {
                          return "Enter your email";
                        } else if (!emailRegex.hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.orange,
                        ),

                        filled: true,
                        fillColor: Color(0xFF2A2A2A),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.white12),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Color(0xFFFF7A00),
                            width: 2,
                          ),
                        ),

                        errorStyle: TextStyle(color: Colors.redAccent),
                      ),
                    ),

                    SizedBox(height: 15),
                    TextFormField(
                      controller: passController,
                      obscureText: isPassHidden,
                      cursorColor: Color(0xFFFF7A00),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your password";
                        } else if (value.length < 6) {
                          return "Password too short";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: Colors.white38),

                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.orange,
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassHidden = !isPassHidden;
                            });
                          },
                          icon: Icon(
                            isPassHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.orange,
                          ),
                        ),

                        filled: true,
                        fillColor: Color(0xFF2A2A2A),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),

                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.white12),
                        ),

                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Color(0xFFFF7A00),
                            width: 2,
                          ),
                        ),

                        errorStyle: TextStyle(color: Colors.redAccent),
                      ),
                    ),

                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Color(0xFFFF7A00),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BlocConsumer<UserBloc,UserState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFF7A00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                isLogin = true;
                                context.read<UserBloc>().add(
                                  LoginUserEvent(
                                    email: emailController.text,
                                    pass: passController.text,
                                  ),
                                );
                              }
                            },
                            child: isLoading ? CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white ,) : Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        listener: (context, state) {
                          if (state is LoadingUserState) {
                            isLoading = true;
                            setState(() {});
                          }
                          if (state is ErrorUserState) {
                            isLoading=false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  state.msg,
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Color(0xFF1F1F1F),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: EdgeInsets.all(10),
                                elevation: 8,
                              ),
                            );
                          }
                          if (state is SuccessUserState) {
                            isLoading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Login Successfully",
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
                            Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                          }
                        },
                        listenWhen: (ps,cs)=>isLogin,
                        buildWhen: (ps,cs)=>isLogin,
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            isLogin = false;
                            Navigator.pushNamed(context, AppRoutes.signUp);
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color(0xFFFF7A00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
