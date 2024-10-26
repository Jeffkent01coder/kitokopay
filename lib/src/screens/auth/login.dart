import 'package:flutter/material.dart';
import 'package:kitokopay/customs/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  // Change MainScreen to LoginScreen
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Right column (now moved to the left)
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey[200],
              child: Image.asset(
                'assets/images/login.png', // Replace with your image asset
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          // Left column (now moved to the right)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Image
                  Center(
                    child: Image.asset(
                      'assets/images/Kitokopaylogo.png', // Replace with your logo asset
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Welcome Text
                  const Center(
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Custom Text Field with Country Picker
                  const Text(
                    "Country",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  // Reusable CustomTextField
                  const CustomTextField(
                    hintText: "+243", // Placeholder text
                  ),

                  const SizedBox(height: 24),

                  // Blue Log In Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Register Now text
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Register Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
