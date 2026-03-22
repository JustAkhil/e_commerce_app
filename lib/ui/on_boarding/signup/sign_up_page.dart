import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  bool isPassHidden = true;
  bool isConfirmPass = true;

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
                  )
                ],
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Sign up to get started",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 25),
                    TextFormField(
                      controller: nameController,
                      cursorColor: Color(0xFFFF7A00),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: "Enter your name",
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixIcon: Icon(Icons.person_outline, color: Colors.orange),
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Color(0xFFFF7A00),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        RegExp emailRegex = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Enter valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: "Enter your email",
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.orange),
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
                        RegExp passwordRegex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                        if (value == null || value.isEmpty) {
                          return 'Enter password';
                        } else if (!passwordRegex.hasMatch(value)) {
                          return 'Weak password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.orange),

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassHidden = !isPassHidden;
                            });
                          },
                          icon: Icon(
                            isPassHidden ? Icons.visibility_off : Icons.visibility,
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

                    SizedBox(height: 15),
                    TextFormField(
                      controller: confirmPassController,
                      obscureText: isConfirmPass,
                      cursorColor: Color(0xFFFF7A00),
                      style: TextStyle(color: Colors.white),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm password';
                        } else if (value != passController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: "Re-enter password",
                        hintStyle: TextStyle(color: Colors.white38),
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.orange),

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isConfirmPass = !isConfirmPass;
                            });
                          },
                          icon: Icon(
                            isConfirmPass ? Icons.visibility_off : Icons.visibility,
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

                    SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF7A00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // signup logic
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFFFF7A00),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
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