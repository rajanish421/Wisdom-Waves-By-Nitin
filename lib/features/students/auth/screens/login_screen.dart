import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Custom_Widget/button.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: AppColors.backgroundColor,

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 60,),
            // Logo
            Image.asset(
              'assets/images/logo1.png', // make sure this is added in pubspec.yaml
              height: 160,
            ),
            const SizedBox(height: 24),

            // Welcome Text
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 26,
                // fontWeight: FontWeight.bold,
                fontFamily: "Titan"
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please login to continue",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),
            // Username Field
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: "Username",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off: Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Login Button with Gradient
            CustomButton(text: "Login", onPressed: (){},),
          ],
        ),
      ),
    );
  }
}
