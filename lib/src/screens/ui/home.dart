import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/atmcarditem.dart';
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/screens/ui/payments.dart';
import 'package:kitokopay/src/customs/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CustomAppBar(),
      ),
      body: Stack(
        children: [
          // Gradient background with wavy lines
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3C4B9D), // Top color (lighter blue)
                  Color(0xFF151A37), // Bottom color (darker blue)
                ],
              ),
            ),
            child: CustomPaint(
              painter: WavyLinePainter(),
              child:
                  Container(), // This container is necessary for CustomPaint to fill the area
            ),
          ),
          // Foreground content
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 10),
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
                          const SizedBox(width: 10),
                          Flexible(
                            child: CardItem(
                              accountNumber: '1234 5678 9101 1122',
                              amount: 'CDF 8,500',
                              isSelected: false,
                              onSelect: () {},
                            ),
                          ),
                          const SizedBox(width: 10),
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
                      const Text(
                        'Quick Services',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Flexible(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PaymentPage(),
                                  ),
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
                          const SizedBox(width: 10),
                          Flexible(
                            child: _buildQuickServiceCard(
                              color: const Color(0xFF7FC1E4),
                              icon: Icons.send,
                              title: 'Remit',
                              description: 'Send money anywhere',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: _buildQuickServiceCard(
                              color: const Color(0xFF7FC1E4),
                              icon: Icons.money,
                              title: 'Get Loan',
                              description: 'Get unsecured personal loan',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(child: _buildAddCardPlaceholder()),
                        ],
                      ),
                      const SizedBox(height: 30),
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
                      Container(
                        width: double.infinity,
                        color: const Color(0xFF4564A8),
                        height:
                            300, // Set a fixed height for the transaction list
                        child: _buildTransactionList(),
                      ),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickServiceCard({
    required Color color,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      height: 120,
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

  Widget _buildAddCardPlaceholder() {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 1.0),
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

  Widget _buildTransactionList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
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
                  fontSize: 16,
                ),
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

// Custom Painter for drawing wavy lines
class WavyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 20) {
      final path = Path();
      path.moveTo(0, y);
      path.quadraticBezierTo(
          size.width / 2, y + 10, size.width, y); // Draw wavy line
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
