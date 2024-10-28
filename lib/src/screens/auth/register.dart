import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/custom_text_field.dart';
import 'package:kitokopay/src/screens/auth/login.dart';

class RegistrationScreen extends StatelessWidget {
  // Change MainScreen to LoginScreen
  const RegistrationScreen({super.key});

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
                'assets/images/register.png', // Replace with your image asset
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
                      width: 120,
                      height: 120,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Welcome Text
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 32), 

                   // Welcome Text
                  const Text(
                      "Enter your phone number to create an account and \n get started",
                      style: TextStyle(
                        fontSize: 14,
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
                        "Register Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
