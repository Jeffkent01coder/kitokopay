import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
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
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Set your base design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
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
            '/remittance': (context) =>
                const RemittancePage(), // Remittance screen
          },
        );
      },
    );
  }
}
