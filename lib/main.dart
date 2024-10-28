import 'package:flutter/material.dart';
import 'package:kitokopay/src/screens/auth/login.dart';
import 'package:kitokopay/src/screens/ui/home.dart';
import 'package:kitokopay/src/screens/ui/loans.dart';
import 'package:kitokopay/src/screens/ui/payments.dart';
import 'package:kitokopay/src/screens/ui/remittance.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(), // Initial screen
        '/home': (context) => const HomeScreen(), // Home screen
        '/payments': (context) => const PaymentPage(), // Payments screen
        '/loans': (context) => const LoansPage(), // Loans screen
        '/remittance': (context) => const RemittancePage(), // remittance screen

        // Add any other screens if needed
      },
    );
  }
}
