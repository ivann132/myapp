import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController emailControl = TextEditingController();
  final TextEditingController passControl = TextEditingController();
  final authControl = Get.find<AuthController>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Email or Phone Input
              TextFormField(
                controller: emailControl,
                decoration: InputDecoration(
                  labelText: 'Your email address/Phone number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password Input
              TextFormField(
                controller: passControl,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Sign in Button
              ElevatedButton(
                onPressed: () async {
                  try {
                    await authControl.signup(
                        emailControl.text, passControl.text);
                  } catch (error) {
                    print("Error during registration: $error");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown, // Background color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize:
                      const Size(double.infinity, 50), // Full-width button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Center(
                // Don't have an account? Sign up
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Have any Account?"),
                    TextButton(
                        onPressed: () => Get.toNamed(Routes.LOGIN),
                        child: const Text("Sign In"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
