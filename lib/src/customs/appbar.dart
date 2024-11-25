import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kitokopay/service/api_client_helper_utils.dart'; // Import the ElmsSSL class

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIndex = -1; // No tab is selected initially
  bool _isLoading = false; // Loading state for Reset Pin
  String? _errorMessage; // Error message for Reset Pin

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });

    // Handle navigation here based on the index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/payments');
        break;
      case 1:
        Navigator.pushNamed(context, '/loans');
        break;
      case 2:
        Navigator.pushNamed(context, '/remittance');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Responsive handling: use menu for narrow screens
        bool isCompact = constraints.maxWidth < 600;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(color: Color(0XFF3C4B9D)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: Image.asset(
                  'assets/images/Kitokopaylogo.png', // Replace with your logo asset path
                  height: 40,
                ),
              ),
              if (!isCompact)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildButton("Payments", 0),
                      const SizedBox(width: 10),
                      _buildButton("Loans", 1),
                      const SizedBox(width: 10),
                      _buildButton("Remittance", 2),
                      const SizedBox(width: 20),
                      _buildPopupMenuButton(),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          _showMenuDialog(context);
                        },
                      ),
                      _buildPopupMenuButton(),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton(String title, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: title == "Loans" // Only enable tap for "Loans"
          ? () => _onItemTapped(index)
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isSelected
              ? Border.all(color: const Color(0xFF7FC1E4), width: 2)
              : Border.all(color: Colors.white, width: 1.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: title == "Loans"
                ? (isSelected ? const Color(0xFF3C4B9D) : Colors.white)
                : Colors.grey, // Disabled buttons appear grey
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildPopupMenuButton() {
    return PopupMenuButton<int>(
      icon: const Icon(
        Icons.account_circle,
        color: Colors.white,
      ),
      onSelected: (int result) {
        switch (result) {
          case 0:
            Navigator.pushNamed(context, '/manage-cards');
            break;
          case 1:
            Navigator.pushNamed(context, '/support');
            break;
          case 2:
            Navigator.pushNamed(context, '/settings');
            break;
          case 3:
            _handleResetPin(); // Handle Reset Pin action
            break;
          case 4:
            Navigator.pushNamed(context, '/about');
            break;
          case 5:
            Navigator.pushNamed(context, '/logout');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 0,
          child: ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Manage Cards'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            leading: Icon(Icons.support_agent),
            title: Text('Get Support'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account Settings'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: ListTile(
            leading: Icon(Icons.lock_reset),
            title: Text('Reset Pin'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 4,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 5,
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          ),
        ),
      ],
    );
  }

  void _showMenuDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text("Loans"),
                onTap: () {
                  Navigator.pop(context);
                  _onItemTapped(1); // Only "Loans" is functional
                },
              ),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text(
                  "Payments",
                  style: TextStyle(color: Colors.grey), // Greyed out
                ),
                onTap: null, // Non-functional
              ),
              ListTile(
                leading: const Icon(Icons.send),
                title: const Text(
                  "Remittance",
                  style: TextStyle(color: Colors.grey), // Greyed out
                ),
                onTap: null, // Non-functional
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleResetPin() async {
    // Show loading dialog
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      ElmsSSL elmsSSL = ElmsSSL();
      String result = await elmsSSL.resetPin();
      Map<String, dynamic> resultMap = jsonDecode(result);

      if (resultMap['status'] == 'success') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = resultMap['message'] ?? 'Invalid details!';
        });
        _showErrorDialog(_errorMessage!);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
      _showErrorDialog(_errorMessage!);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
