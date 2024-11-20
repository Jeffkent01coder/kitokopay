import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/screens/ui/loans/applyloan/loanConfrimation.dart';
import 'package:kitokopay/src/screens/ui/loans/applyloan/loanfailed.dart';
import 'package:kitokopay/src/screens/ui/loans/applyloan/loanpin.dart';
import 'package:kitokopay/src/screens/ui/loans/applyloan/loansuccess.dart';
import 'package:kitokopay/src/screens/ui/loans/myloans/myloans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../customs/appbar.dart';
import 'package:kitokopay/service/api_client_helper_utils.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  int _selectedTabIndex = 0;
  double _selectedAmount = 0.0;
  double _limitAmount = 0.0;
  String _leftPanelStage = "slider";
  final TextEditingController _pinController = TextEditingController();
  // Variables to hold loan details
  String _loanId = "N/A";
  String _loanStatus = "N/A";
  String _principalAmount = "0.0";
  String _currentBalance = "0.0";
  String _date = "N/A";
  String _referenceId = "N/A";
  String _repaymentDate = "N/A";
  String _requestType = "N/A";
  String _mobileNumber = "N/A";
  String _names = "N/A";
  String _customerId = "N/A";

  @override
  void initState() {
    super.initState();
    _fetchLimitAmount();
  }

  Future<void> _fetchLimitAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginDetails = prefs.getString('loginDetails');
    if (loginDetails != null) {
      final parsedLogin = jsonDecode(loginDetails);
      final loans = parsedLogin['Data']['Loans'][0]; // Assuming first loan
      setState(() {
        _loanId = loans['LoanId'] ?? "N/A";
        _loanStatus = loans['LoanStatus'] ?? "N/A";
        _principalAmount = loans['PrincipalAmount'] ?? "0.0";
        _currentBalance = loans['CurrentBalance'] ?? "0.0";
        _date = loans['Date'] ?? "N/A";
        _referenceId = loans['ReferenceId'] ?? "N/A";
        _repaymentDate = loans['RepaymentDate'] ?? "N/A";
        _requestType = loans['RequestType'] ?? "N/A";
        _mobileNumber = loans['MobileNumber'] ?? "N/A";
        _names = loans['Names'] ?? "N/A";
        _customerId = loans['Id'] ?? "N/A";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3C4B9D),
                  Color(0xFF151A37),
                ],
              ),
            ),
            child: CustomPaint(
              painter: WavyLinePainter(),
              child: Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildCardTabBar(),
                const SizedBox(height: 30),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildLeftPanel(),
                      ),
                      Container(
                        width: 1,
                        height: double.infinity,
                        color: Colors.white.withOpacity(0.4),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      Expanded(
                        child: _buildRightPanel(),
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

  Widget _buildLeftPanel() {
    switch (_leftPanelStage) {
      case "slider":
        return _buildSliderSection(
          "Loan Amount",
          "CDF ${_selectedAmount.toStringAsFixed(0)}",
          "CDF 0",
          "CDF ${_limitAmount.toStringAsFixed(0)}",
        );
      case "confirmation":
        return _buildConfirmationScreen();
      case "pin":
        return _buildPinScreen();
      case "failure":
        return _buildFailureScreen();
      default:
        return Container();
    }
  }

  Widget _buildRightPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          "Principal Amount",
          "CDF $_principalAmount",
          "Current Balance",
          "CDF $_currentBalance",
        ),
        const SizedBox(height: 16),
        _buildDetailsRow(
          "Repayment Date",
          _repaymentDate,
          "Loan Status",
          _loanStatus,
        ),
        const SizedBox(height: 16),
        _buildDetailsRow(
          "Reference ID",
          _referenceId,
          "Request Type",
          _requestType,
        ),
        const SizedBox(height: 16),
        const Text(
          "Account Holder",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _names,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _mobileNumber,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
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
    );
  }

  Widget _buildSliderSection(
      String title, String rightLabel, String leftValue, String rightValue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Slider(
          value: _selectedAmount,
          min: 0,
          max: _limitAmount,
          onChanged: (value) {
            setState(() {
              _selectedAmount = value;
            });
          },
          activeColor: Colors.white,
          inactiveColor: Colors.white.withOpacity(0.3),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(leftValue,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
            Text(rightValue,
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _leftPanelStage = "confirmation";
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
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
    );
  }

  Widget _buildConfirmationScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Confirmation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Please confirm your loan application.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _leftPanelStage = "slider";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _leftPanelStage = "pin";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                'Confirm Loan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPinScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Enter PIN",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Please enter your PIN to \n complete loan request.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),

        // PIN Input Field styled according to requirements
        SizedBox(
          width: 150,
          child: TextField(
            controller: _pinController,
            keyboardType: TextInputType.number,
            maxLength: 4,
            obscureText: true,
            decoration: InputDecoration(
              counterText: '',
              hintText: '----',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Submit Button
        ElevatedButton(
          onPressed: () {
            _processLoan();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
          ),
          child: const Text(
            'Submit PIN',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildFailureScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 250,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/failed.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          "Failed!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Your loan request has been rejected.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _leftPanelStage = "slider";
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'Done',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<void> _processLoan() async {
    final enteredPin = _pinController.text;

    if (enteredPin.isEmpty) return;

    // Call applyLoan function from ElmsSSL class
    final response = await ElmsSSL().applyLoan(
      _selectedAmount.toString(),
      enteredPin,
    );

    final responseJson = jsonDecode(response);

    if (responseJson['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoanSuccessPage()),
      );
    } else {
      setState(() {
        _leftPanelStage = "failure";
      });
    }
  }

  Widget _buildDetailsRow(String leftTitle, String leftValue, String rightTitle,
      String rightValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(leftTitle, style: const TextStyle(color: Colors.white)),
          Text(leftValue,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(rightTitle, style: const TextStyle(color: Colors.white)),
          Text(rightValue,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ]),
      ],
    );
  }

  Widget _buildCardTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoansPage()));
        } else if (index == 1) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyLoansPage()));
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF3C4B9D) : Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              height: 2,
              width: 40,
              color: const Color(0xFF3C4B9D),
              margin: const EdgeInsets.only(top: 4),
            ),
        ],
      ),
    );
  }

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
