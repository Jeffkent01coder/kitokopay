import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/atmcarditem.dart';
import 'package:kitokopay/src/customs/sidemenubar.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  int? selectedCardIndex;

  void onCardSelect(int index) {
    setState(() {
      if (selectedCardIndex == index) {
        selectedCardIndex = null;
      } else {
        selectedCardIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3C4B9D),
      body: Row(
        children: [
          const SidebarMenu(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Hi Jeff',
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
                      Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
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
                                const SizedBox(width: 10),
                                Expanded(
                                  child: CardItem(
                                    accountNumber: '1234 5678 9101 1122',
                                    amount: 'CDF 8,500',
                                    isSelected: selectedCardIndex == 1,
                                    onSelect: () => onCardSelect(1),
                                  ),
                                ),
                                const SizedBox(width: 10),
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'CDF 64,000',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF7FC1E4),
                                                    ),
                                                    child: const Text('Repay',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Application Date:',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  Row(
                                                    children: [
                                                      Text('1 June 2024',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(width: 8),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'CDF 32,000',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF7FC1E4),
                                                    ),
                                                    child: const Text('Repay',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Application Date:',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  Row(
                                                    children: [
                                                      Text('15 July 2024',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      SizedBox(width: 8),
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
                                    color: Colors.white, thickness: 1),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Loan Details',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
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
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              const SizedBox(height: 10),
                                              loanDetailRow(
                                                  'Loan Amount:', 'CDF 65250'),
                                              loanDetailRow('Repayment Date:',
                                                  '16th August 2024'),
                                              loanDetailRow('Principal Amount:',
                                                  'CDF 60,000'),
                                              loanDetailRow('Interest Paid:',
                                                  'CDF 1,864'),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF7FC1E4),
                                          ),
                                          child: const Text('Repay Loan',
                                              style: TextStyle(
                                                  color: Colors.white)),
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
            ),
          ),
        ],
      ),
    );
  }

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
