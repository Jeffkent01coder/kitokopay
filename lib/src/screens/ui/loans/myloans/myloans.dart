import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/appbar.dart';
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/screens/ui/loans.dart';

class MyLoansPage extends StatefulWidget {
  const MyLoansPage({super.key});

  @override
  State<MyLoansPage> createState() => _MyLoansPageState();
}

class _MyLoansPageState extends State<MyLoansPage> {
  int _selectedTabIndex = 0;
  int _selectedCardIndex = -1; // For tracking the selected loan card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C4B9D),
      appBar: const CustomAppBar(), // Custom app bar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWeb = constraints.maxWidth > 600;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildCardTabBar(), // Tab bar for navigation
                const SizedBox(height: 20),
                Expanded(
                  child: isWeb
                      ? Row(
                          children: [
                            // Left Column (Loans Title and Cards)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "My Loans",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildLoanCard(
                                      0, 'CDF 64,000', '1 June 2024'),
                                  const SizedBox(height: 10),
                                  _buildLoanCard(
                                      1, 'CDF 75,000', '5 July 2024'),
                                  const SizedBox(height: 10),
                                  _buildLoanCard(
                                      2, 'CDF 55,000', '10 August 2024'),
                                ],
                              ),
                            ),

                            // Vertical Divider
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: Colors.white.withOpacity(0.4),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
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
                                  _buildDetailsRow(
                                    "Loan Amount",
                                    "CDF 27,000",
                                    "Repayment Date",
                                    "18.08.2024",
                                  ),
                                  const SizedBox(height: 16),
                                  _buildDetailsRow(
                                    "Interest Rate",
                                    "10 %",
                                    "Repayment Amount",
                                    "CDF  28,500",
                                  ),
                                  const SizedBox(height: 16),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        "123 456 5789",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  const Card(
                                    color: Color(0xFF4C6DB2),
                                    margin: EdgeInsets.only(top: 16),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        "Loan conditions have been set \n based on your credit rating. \n Terms & Conditions",
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
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "My Loans",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildLoanCard(0, 'CDF 64,000', '1 June 2024'),
                            const SizedBox(height: 10),
                            _buildLoanCard(1, 'CDF 75,000', '5 July 2024'),
                            const SizedBox(height: 10),
                            _buildLoanCard(2, 'CDF 55,000', '10 August 2024'),
                            const SizedBox(height: 20),
                            const Text(
                              "Loan Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildDetailsRow(
                              "Loan Amount",
                              "CDF 27,000",
                              "Repayment Date",
                              "18.08.2024",
                            ),
                            const SizedBox(height: 16),
                            _buildDetailsRow(
                              "Interest Rate",
                              "10 %",
                              "Repayment Amount",
                              "CDF  28,500",
                            ),
                            const SizedBox(height: 16),
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
                                  "123 456 5789",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
                const Footer(), // Footer widget
              ],
            );
          },
        ),
      ),
    );
  }

  // Build loan card with selectable functionality
  Widget _buildLoanCard(int index, String amount, String date) {
    final isSelected = _selectedCardIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCardIndex = index;
        });
      },
      child: Card(
        color: const Color(0xFF4564A8),
        shape: isSelected
            ? RoundedRectangleBorder(
                side: const BorderSide(color: Colors.lightBlue, width: 2.0),
                borderRadius: BorderRadius.circular(10),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Amount Borrowed',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7FC1E4),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Application Date:',
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
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
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white
              : const Color(0xFF3C4B9D), // Blue for selected tab
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF3C4B9D) : Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  // Tab bar containing loan and repayments
  Widget _buildCardTabBar() {
    return Row(
      children: [
        _buildCardTab('Loans', 0),
        _buildCardTab('Repayments', 1),
        _buildCardTab('New Loan', 2),
      ],
    );
  }

  // Helper to build loan detail rows
  Widget _buildDetailsRow(
      String leftText, String leftValue, String rightText, String rightValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              leftText,
              style: const TextStyle(color: Colors.white),
            ),
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
              rightText,
              style: const TextStyle(color: Colors.white),
            ),
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
}
