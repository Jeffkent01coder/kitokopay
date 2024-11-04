import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/custom_text_field.dart';
import 'package:kitokopay/src/screens/auth/register.dart';
import 'package:kitokopay/src/screens/ui/home.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left column with image - only visible on wider screens
              if (constraints.maxWidth > 600)
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

              // Right column with form
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
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
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Country Label
                      const Text(
                        "Country",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),

                      // Custom Text Field with Country Picker
                      const CustomTextField(
                        hintText: "+243", // Placeholder text
                      ),

                      const SizedBox(height: 24),

                      // Log In Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(
                            child: Text(
                              "Don't have an account?",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              " Register Now",
                              style: TextStyle(
                                color: Colors.black,
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
            ],
          );
        },
      ),
    );
  }
}
