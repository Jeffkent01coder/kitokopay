import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/atmcarditem.dart'; // Ensure this import is valid
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/screens/ui/payments.dart'; // Ensure this import is valid
import 'package:kitokopay/src/customs/appbar.dart'; // Import your CustomAppBar

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF3C4B9D), // Background color for the screen
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Adjust height as needed
        child: CustomAppBar(), // Use your CustomAppBar here
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Your Cards Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Cards',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View All',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Card items
                  const SizedBox(height: 10), // Added spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CardItem(
                          accountNumber: '1234 5678 9101 1121',
                          amount: 'CDF 10,000',
                          isSelected: false,
                          onSelect: () {},
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between cards
                      Flexible(
                        child: CardItem(
                          accountNumber: '1234 5678 9101 1122',
                          amount: 'CDF 8,500',
                          isSelected: false,
                          onSelect: () {},
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between cards
                      Flexible(
                        child: CardItem(
                          accountNumber: '1234 5678 9101 1123',
                          amount: 'CDF 5,000',
                          isSelected: false,
                          onSelect: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Quick Services Section
                  const Text(
                    'Quick Services',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quick Services Cards with spacing between them
                  Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PaymentPage()),
                            );
                          },
                          child: _buildQuickServiceCard(
                            color: const Color(0xFF7FC1E4),
                            icon: Icons.payment,
                            title: 'Payments',
                            description: 'Pay for goods and services',
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between cards
                      Flexible(
                        child: _buildQuickServiceCard(
                          color: const Color(0xFF7FC1E4),
                          icon: Icons.send,
                          title: 'Remit',
                          description: 'Send money anywhere',
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between cards
                      Flexible(
                        child: _buildQuickServiceCard(
                          color: const Color(0xFF7FC1E4),
                          icon: Icons.money,
                          title: 'Get Loan',
                          description: 'Get unsecured personal loan',
                        ),
                      ),
                      const SizedBox(width: 10), // Spacing between cards
                      Flexible(child: _buildAddCardPlaceholder()),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Recent Transactions Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7FC1E4),
                        ),
                        onPressed: () {},
                        child: const Text('Recent Transactions'),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Spending',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Loans',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Transactions List
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: const Color(0xFF4564A8),
                      child:
                          _buildTransactionList(), // Temporary Transaction List
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Footer(), // Add Footer here
        ],
      ),
    );
  }

  // Quick service card builder
  Widget _buildQuickServiceCard({
    required Color color,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      height: 120, // Increased height for better layout
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Add card placeholder builder
  Widget _buildAddCardPlaceholder() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Colors.white, style: BorderStyle.solid, width: 1.0),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 24, color: Colors.white),
          SizedBox(height: 10),
          Text(
            'Add Card',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Add another virtual card',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Transaction list
  Widget _buildTransactionList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5, // Replace with dynamic transaction count
      separatorBuilder: (context, index) => const Divider(color: Colors.white),
      itemBuilder: (context, index) {
        return const ListTile(
          leading: Icon(Icons.arrow_downward, color: Colors.white),
          title: Text(
            'Airtel Money',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '14th August 2024',
            style: TextStyle(color: Colors.white),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'CDF 3,000',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                'Mike Madilu',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
