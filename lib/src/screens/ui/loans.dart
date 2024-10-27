import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/atmcarditem.dart';
import 'package:kitokopay/src/customs/sidemenubar.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  // Track the selected card index (or null if none is selected)
  int? selectedCardIndex;

  void onCardSelect(int index) {
    setState(() {
      // If the selected card is already selected, deselect it
      if (selectedCardIndex == index) {
        selectedCardIndex = null;
      } else {
        selectedCardIndex = index; // Select the new card
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C4B9D), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF4564A8),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Row(
              children: [
                Text(
                  'Hi Jeff', // Username
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF3C4B9D)),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          // Sidebar Menu
          Container(
            width: 250, // Adjust width as necessary
            color: const Color(
                0xFF3C4B9D), // Optional: Set background color for sidebar
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context); // Navigate back
                        },
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'My Loans',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: SidebarMenu()), // Sidebar menu items
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // Use SingleChildScrollView to avoid overflow
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Choose Card',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CardItem(
                            accountNumber: '1234 5678 9101 1121',
                            amount: 'CDF 10,000',
                            isSelected: selectedCardIndex == 0,
                            onSelect: () => onCardSelect(0),
                          ),
                        ),
                        const SizedBox(width: 10), // Spacing between cards
                        Expanded(
                          child: CardItem(
                            accountNumber: '1234 5678 9101 1122',
                            amount: 'CDF 8,500',
                            isSelected: selectedCardIndex == 1,
                            onSelect: () => onCardSelect(1),
                          ),
                        ),
                        const SizedBox(width: 10), // Spacing between cards
                        Expanded(
                          child: CardItem(
                            accountNumber: '1234 5678 9101 1123',
                            amount: 'CDF 5,000',
                            isSelected: selectedCardIndex == 2,
                            onSelect: () => onCardSelect(2),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Loan History and Details Section
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align items to the top
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Loan History',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 10),
                             Card(
                                color: const Color(0xFF4564A8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'CDF 64,000',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF7FC1E4),
                                            ),
                                            child: const Text('Repay',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Application Date:',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '1 June 2024',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                  width:
                                                      8), // Space between date and icon
                                              Icon(Icons.arrow_forward,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

// Add more loan cards as needed
                              Card(
                                color: const Color(0xFF4564A8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Another Loan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'CDF 32,000',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xFF7FC1E4),
                                            ),
                                            child: const Text('Repay',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Application Date:',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '15 July 2024',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                  width:
                                                      8), // Space between date and icon
                                              Icon(Icons.arrow_forward,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                        const VerticalDivider(
                            color: Colors.white,
                            thickness: 1), // White vertical line divider
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Loan Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              // Move Card to the top of its column
                              Card(
                                color: const Color(0xFF4564A8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF7FC1E4),
                                        ),
                                        child: const Text('Active',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      const SizedBox(height: 10),
                                      loanDetailRow('Loan Amount:', 'CDF 65250'),
                                      loanDetailRow('Repayment Date:', '16th August 2024'),
                                      loanDetailRow('Principal Amount:', 'CDF 60,000'),
                                      loanDetailRow('Interest Paid:', 'CDF 1,864'),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ),
                              ),

                              // Center the button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7FC1E4),
                                  ),
                                  child: const Text('Repay Loan',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create a loan detail row
  Widget loanDetailRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white)),
        Text(amount, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
