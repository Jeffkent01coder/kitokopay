import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final String accountNumber;
  final String amount;
  final bool isSelected; // New parameter for selection state
  final VoidCallback onSelect; // Callback to handle selection

  const CardItem({
    super.key,
    required this.accountNumber,
    required this.amount,
    required this.isSelected, // Add isSelected parameter
    required this.onSelect, // Add onSelect callback
  });

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  // State for showing/hiding account number
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSelect, // Trigger selection callback on tap
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4C6DB2), Color(0xFF3C4B9D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border: widget.isSelected // Change border based on selection
              ? Border.all(color: Colors.lightBlue, width: 2)
              : null,
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo at the top left
            Row(
              children: [
                Image.asset(
                  'assets/images/Kitokopaylogo.png', // Replace with your logo asset
                  width: 40,
                  height: 40,
                ),
                const Spacer(),
                // Show "Selected" text if the card is selected
                if (widget.isSelected)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Selected',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),

            // Amount display
            Text(
              widget.amount,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Account number and hide/unhide row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Account number (show/hide based on _isHidden state)
                Text(
                  _isHidden ? '•••• •••• •••• ••••' : widget.accountNumber,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),

                // Hide/Unhide icon with text
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isHidden = !_isHidden; // Toggle the hide/unhide state
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _isHidden ? 'Hide' : 'Unhide',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
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
    );
  }
}
