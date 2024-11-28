import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kitokopay/src/screens/auth/login.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  factory SessionManager() => _instance;
  SessionManager._internal();

  DateTime? _lastActivityTime;
  final Duration _timeoutDuration = const Duration(minutes: 5);
  VoidCallback? onSessionTimeout;

  // Track user activity
  void updateActivity() {
    _lastActivityTime = DateTime.now();
  }

  // Check session timeout
  void startSessionTimeoutWatcher(BuildContext context) {
    _lastActivityTime = DateTime.now();

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1)); // Check every second
      if (_lastActivityTime == null) return false;

      final currentTime = DateTime.now();
      final elapsedTime = currentTime.difference(_lastActivityTime!);

      if (elapsedTime >= _timeoutDuration) {
        _handleSessionTimeout(context);
        return false; // Stop watcher
      }

      return true; // Continue checking
    });
  }

  void _handleSessionTimeout(BuildContext context) async {
    // Clear preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Trigger callback or navigate to login
    if (onSessionTimeout != null) {
      onSessionTimeout!();
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  // Clear session explicitly
  void clearSession(BuildContext context) async {
    _lastActivityTime = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
