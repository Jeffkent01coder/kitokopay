import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/screens/ui/loans/applyloan/loanConfrimation.dart';
import 'package:kitokopay/src/screens/ui/loans/myloans/myloans.dart';
import '../../customs/appbar.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(), // Custom app bar

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Card tab bar for navigation
                _buildCardTabBar(),
                const SizedBox(height: 30),
                Expanded(
                  child: Row(
                    children: [
                      // Left Column (Apply Loan)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Apply Loan title
                            const Text(
                              "Apply Loan",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Loan Amount slider
                            _buildSliderSection("Loan Amount", "CDF 27,000",
                                "CDF 10,000", "CDF 150,000"),

                            const SizedBox(height: 16),

                            // Due Date slider
                            _buildSliderSection(
                                "Due Date", "30 Days", "10 Days", "30 Days"),

                            const SizedBox(height: 30),

                            // Continue Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigate to the LoanConfirmationPage
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoanConfirmationPage()), // Ensure LoanConfirmationPage is imported
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.lightBlue, // Skyblue background
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Vertical Divider
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: Colors.white.withOpacity(0.4),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                      ),

                      // Right Column (Loan Details)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Loan Details title
                            const Text(
                              "Loan Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Row 1: Loan Amount and Repayment Date
                            _buildDetailsRow("Loan Amount", "CDF 27,000",
                                "Repayment Date", "18.08.2024"),

                            const SizedBox(height: 16),

                            // Row 2: Interest Rate and Repayment Amount
                            _buildDetailsRow("Interest Rate", "10%",
                                "Repayment Amount", "CDF 28,500"),

                            const SizedBox(height: 16),

                            // Row 3: Loan Recipient Account
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Loan Recipient Account",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "+243 123 456 789",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 30),

                            // Final loan conditions card
                            const Card(
                              color: Color(0xFF4C6DB2),
                              margin: EdgeInsets.only(top: 16),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Final loan conditions will be specified when the application is approved.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Footer(), // Footer widget
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the loan amount and due date slider section
  Widget _buildSliderSection(
      String title, String rightLabel, String leftValue, String rightValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row with title and right label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Text(
              rightLabel,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Slider with - and + buttons
        Row(
          children: [
            _buildCircleIcon(Icons.remove),
            Expanded(
              child: Slider(
                value: 0.5,
                onChanged: (value) {
                  // Handle slider value change
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.3),
              ),
            ),
            _buildCircleIcon(Icons.add),
          ],
        ),
        // Min and max value labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftValue,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              rightValue,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Function to build the card details row
  Widget _buildDetailsRow(String leftTitle, String leftValue, String rightTitle,
      String rightValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftTitle,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              leftValue,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rightTitle,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 4),
            Text(
              rightValue,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  // Function to build the circle icon for add/remove buttons
  Widget _buildCircleIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  // Build individual tab for the card tab bar
  Widget _buildCardTab(String title, int index) {
    final isSelected =
        _selectedTabIndex == index; // Check if the tab is selected

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index; // Update the selected tab index
        });

        // Navigate to the appropriate screen when the tab is clicked
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoansPage()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyLoansPage()),
          );
        } else {
          print("hello jeff");
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF3C4B9D)
                  : Colors.white, // Change color if selected
              fontWeight: isSelected
                  ? FontWeight.bold
                  : FontWeight.normal, // Bold if selected
              decoration: TextDecoration.none, // Remove underline
            ),
          ),
          // Line below the text if the tab is selected
          if (isSelected)
            Container(
              height: 2, // Height of the line
              width: 40, // Width of the line
              color: const Color(0xFF3C4B9D), // Color of the line
              margin: const EdgeInsets.only(top: 4), // Margin above the line
            ),
        ],
      ),
    );
  }

    // Build card tab bar for navigation
  Widget _buildCardTabBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCardTab('Apply Loan', 0),
          _buildCardTab('My Loans', 1),
          _buildCardTab('Credit History', 2),
        ],
      ),
    );
  }
}

// CustomPainter for the wavy line
class WavyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 20) {
      final path = Path();
      for (double x = 0; x < size.width; x += 10) {
        path.lineTo(x, y + 5 * (x % 20 == 0 ? -1 : 1));
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
