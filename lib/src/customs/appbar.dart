import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  int _selectedIndex = -1; // No tab is selected initially

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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0XFF3C4B9D)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to HomeScreen when the logo is tapped
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Image.asset(
              'assets/images/Kitokopaylogo.png', // Replace with your logo asset path
              height: 40, // Adjust height as needed
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildNavItem("Payments", 0),
                const SizedBox(width: 20),
                _buildNavItem("Loans", 1),
                const SizedBox(width: 20),
                _buildNavItem("Remittance", 2),
                const SizedBox(width: 20),
                _buildPopupMenuButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String title, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 60,
              color: const Color(0xFF7FC1E4),
            ),
          const SizedBox(height: 10),
        ],
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
            Navigator.pushNamed(context, '/about');
            break;
          case 4:
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
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          value: 3,
          child: ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 4,
          child: ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
          ),
        ),
      ],
    );
  }
}
