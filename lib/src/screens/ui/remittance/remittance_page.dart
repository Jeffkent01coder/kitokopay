import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/appbar.dart';
import 'package:kitokopay/src/customs/atmcarditem.dart';
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/customs/t-shaped.dart';

class RemittancePageDetails extends StatefulWidget {
  const RemittancePageDetails({super.key});

  @override
  State<RemittancePageDetails> createState() => _RemittancePageDetailsState();
}

class _RemittancePageDetailsState extends State<RemittancePageDetails> {
  static const Color _primaryColor = Color(0xFF3C4B9D);
  static const Color _secondaryColor = Colors.lightBlue;

  final TextEditingController _recipientTransactionController =
      TextEditingController();
  final TextEditingController _sendersTransactionController =
      TextEditingController();
  final TextEditingController _transactionPurpose = TextEditingController();

  String _selectedOption = 'Select Payment Method';
  int _selectedCardIndex = -1;
  int _selectedTabIndex = 0;
  String _selectedCurrency = 'Select Currency';

  final List<Map<String, String>> _currencies = [
    {'code': 'USD', 'name': 'US Dollar'},
    {'code': 'EUR', 'name': 'Euro'},
    {'code': 'GBP', 'name': 'British Pound'},
    {'code': 'JPY', 'name': 'Japanese Yen'},
    {'code': 'AUD', 'name': 'Australian Dollar'},
    {'code': 'CAD', 'name': 'Canadian Dollar'},
    {'code': 'CHF', 'name': 'Swiss Franc'},
    {'code': 'CNY', 'name': 'Chinese Yuan'},
  ];

  final Map<String, List<String>> _paymentOptions = {
    'USD': ['Bank Transfer', 'Wire Transfer', 'Digital Wallet'],
    'EUR': ['SEPA', 'Wire Transfer', 'Digital Wallet'],
    'GBP': ['BACS', 'CHAPS', 'Digital Wallet'],
    'JPY': ['Bank Transfer', 'Digital Wallet'],
    'AUD': ['NPP', 'BPAY', 'Digital Wallet'],
    'CAD': ['Interac', 'Wire Transfer', 'Digital Wallet'],
    'CHF': ['Bank Transfer', 'Digital Wallet'],
    'CNY': ['UnionPay', 'Alipay', 'WeChat Pay'],
  };

  @override
  void dispose() {
    _recipientTransactionController.dispose();
    _sendersTransactionController.dispose();
    _transactionPurpose.dispose();
    super.dispose();
  }

  void _onCardSelect(int index) {
    setState(() {
      _selectedCardIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: _primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCardTabBar(),
            _buildCardSelection(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(child: _buildTransactionDetailsColumn()),
                    const TSeparator(),
                    const SizedBox(width: 16),
                    Expanded(child: _buildSearchRecipientColumn()),
                  ],
                ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTabBar() {
    return Card(
      color: _secondaryColor,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTab('Send Money', 0),
            _buildTab('Transactions', 1),
            _buildTab('Manage Recipients', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? _primaryColor : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              margin: const EdgeInsets.only(top: 4),
              color: _primaryColor,
            ),
        ],
      ),
    );
  }

  Widget _buildCardSelection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: List.generate(3, (index) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 0 : 10,
                right: index == 2 ? 0 : 10,
              ),
              child: CardItem(
                accountNumber: '1234 5678 9101 112${index + 1}',
                amount: 'CDF ${10000 - (index * 2500)}',
                isSelected: _selectedCardIndex == index,
                onSelect: () => _onCardSelect(index),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTransactionDetailsColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Transaction Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        _buildCurrencySelector(),
        const SizedBox(height: 20),
        _buildOperatorDropdown(),
        const SizedBox(height: 20),
        _buildTransactionPurposeField(),
        const SizedBox(height: 20),
        _buildContinueButton(),
      ],
    );
  }

  Widget _buildTransactionPurposeField() {
    return TextField(
      controller: _transactionPurpose,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Purpose of funds transfer",
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: _secondaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Currency",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCurrency,
          dropdownColor: _primaryColor,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          items: [
            const DropdownMenuItem(
              value: 'Select Currency',
              child: Text(
                'Select Currency',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ..._currencies.map<DropdownMenuItem<String>>((currency) {
              return DropdownMenuItem<String>(
                value: currency['code'],
                child: Text(
                  '${currency['code']} - ${currency['name']}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }),
          ],
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedCurrency = newValue;
                _selectedOption = 'Select Payment Method';
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildOperatorDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recipient Operator",
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedOption,
          dropdownColor: _primaryColor,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          items: _getPaymentOptions()
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() => _selectedOption = newValue);
            }
          },
        ),
      ],
    );
  }

  List<String> _getPaymentOptions() {
    if (_selectedCurrency == 'Select Currency') {
      return ['Select Payment Method'];
    }
    return _paymentOptions[_selectedCurrency] ?? ['Select Payment Method'];
  }

  Widget _buildSearchRecipientColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTransferRateSection(),
        const SizedBox(height: 20),
        _buildRecipientsGrid(),
        const SizedBox(height: 20),
        _buildSearchField(),
        const SizedBox(height: 20),
        _buildRecipientsList(),
      ],
    );
  }

  Widget _buildTransferRateSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transfer Rate',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'You send - 270',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Chip(
          label: Text(
            "GBP",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientsGrid() {
    final recipients = [
      {'name': 'Jeff dev', 'isAdd': false},
      {'name': 'Kim dev', 'isAdd': false},
      {'name': 'Hilda dev', 'isAdd': false},
      {'name': 'Add Recipient', 'isAdd': true},
    ];

    return Row(
      children: recipients.map((recipient) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: _buildRecipientItem(
              name: recipient['name'] as String,
              isAdd: recipient['isAdd'] as bool,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecipientItem({required String name, required bool isAdd}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isAdd ? Colors.transparent : _secondaryColor,
            borderRadius: BorderRadius.circular(8.0),
            border: isAdd ? Border.all(color: Colors.white, width: 1.0) : null,
          ),
          child: Icon(
            isAdd ? Icons.add : Icons.person_2_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Search Recipient',
        hintStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        suffixIcon: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  Widget _buildRecipientsList() {
    final recipients = [
      {'name': 'Jeff dev', 'account': '456878'},
      {'name': 'Kim dev', 'account': '8080808'},
      {'name': 'Kings Dev', 'account': '0038383'},
    ];

    return Card(
      color: const Color(0xFF4564A8),
      child: Column(
        children: recipients.asMap().entries.map((entry) {
          final isLast = entry.key == recipients.length - 1;
          return Column(
            children: [
              _buildRecipientListItem(
                entry.value['name'] ?? '',
                entry.value['account'] ?? '',
              ),
              if (!isLast) const Divider(color: Colors.white),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRecipientListItem(String name, String account) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          const Icon(Icons.person_2_outlined, color: Colors.white),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
        ]));
  }
}
