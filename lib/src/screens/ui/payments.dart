import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/atmcarditem.dart';
import 'package:kitokopay/src/customs/sidemenubar.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int? selectedCardIndex;
  String selectedText = '';

  void onCardSelect(int index) {
    setState(() {
      selectedCardIndex = selectedCardIndex == index ? null : index;
    });
  }

  void onTextSelect(String text) {
    setState(() {
      selectedText = selectedText == text ? '' : text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF3C4B9D),
        appBar: AppBar(
          backgroundColor: const Color(0xFF4564A8),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
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
            ),
          ],
        ),
        body: Row(
          children: [
            // Sidebar Menu
            Container(
              width: 250,
              color: const Color(0xFF3C4B9D),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Payments',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SidebarMenu()),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                // Newly Added Sky Blue Card
                                Container(
                                  color:
                                      Colors.lightBlue, // Sky blue background
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () =>
                                            onTextSelect('Initiate Payment'),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Initiate Payment',
                                              style: TextStyle(
                                                color: selectedText ==
                                                        'Initiate Payment'
                                                    ? const Color(0xFF3C4B9D)
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (selectedText ==
                                                'Initiate Payment')
                                              Container(
                                                height: 2,
                                                color: const Color(0xFF3C4B9D),
                                                width: 110,
                                              ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => onTextSelect('Payments'),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Payments',
                                              style: TextStyle(
                                                color: selectedText ==
                                                        'Payments'
                                                    ? const Color(0xFF3C4B9D)
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (selectedText == 'Payments')
                                              Container(
                                                height: 2,
                                                color: const Color(0xFF3C4B9D),
                                                width: 70,
                                              ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            onTextSelect('Manage Favorites'),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Manage Favorites',
                                              style: TextStyle(
                                                color: selectedText ==
                                                        'Manage Favorites'
                                                    ? const Color(0xFF3C4B9D)
                                                    : Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (selectedText ==
                                                'Manage Favorites')
                                              Container(
                                                height: 2,
                                                color: const Color(0xFF3C4B9D),
                                                width: 150,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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

                                // Payment and Business Search Columns
                                Row(
                                  children: [
                                    // Payment Column
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Payment Merchant',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text(
                                            'Pay to',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          const SizedBox(height: 8),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Please enter account number',
                                              hintStyle: const TextStyle(
                                                  color: Colors.white),
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              suffixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          const Text(
                                            'Amount',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          const SizedBox(height: 8),
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Please enter amount',
                                              hintStyle: const TextStyle(
                                                  color: Colors.white),
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.lightBlue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: const Text('Continue',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const VerticalDivider(
                                        color: Colors.white, thickness: 1),
                                    // Business Search Column
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Search Business',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          // Business Cards Row
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.lightBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: const Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      'AirBnb',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.lightBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: const Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      'Spotify',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                        color: Colors.lightBlue,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: const Icon(
                                                          Icons.shopping_cart,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      'Netflix',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: Colors.white,
                                                          style:
                                                              BorderStyle.solid,
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                          Icons.add,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    const Text(
                                                      'Add Business',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          // Account Search Field
                                          TextField(
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Please enter account number',
                                              hintStyle: const TextStyle(
                                                  color: Colors.white),
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                borderSide: const BorderSide(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              suffixIcon: const Icon(
                                                  Icons.search,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          // Business List
                                          Card(
                                            color: const Color(0xFF4564A8),
                                            child: Column(
                                              children: [
                                                businessListItem(Icons.videocam,
                                                    'Netchill', '456878'),
                                                const Divider(
                                                    color: Colors.white),
                                                businessListItem(Icons.store,
                                                    'Apple Store', '8080808'),
                                                const Divider(
                                                    color: Colors.white),
                                                businessListItem(
                                                    Icons.bike_scooter,
                                                    'Jumia',
                                                    '0038383'),
                                              ],
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
            ),
          ],
        ));
  }

  Widget businessListItem(
      IconData icon, String businessName, String accountNumber) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Text(businessName, style: const TextStyle(color: Colors.white)),
          const Spacer(),
          Text(accountNumber, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
