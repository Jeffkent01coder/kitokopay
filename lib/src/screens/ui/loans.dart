import 'package:flutter/material.dart';
import 'package:kitokopay/src/customs/footer.dart';
import 'package:kitokopay/src/screens/ui/home.dart';
import 'package:kitokopay/src/screens/ui/loans/myloans/myloans.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:kitokopay/service/api_client_helper_utils.dart'; // Import the ElmsSSL class
import 'package:kitokopay/src/customs/appbar.dart';
import 'package:kitokopay/src/screens/utils/session_manager.dart';

class LoansPage extends StatefulWidget {
  const LoansPage({super.key});

  @override
  _LoansPageState createState() => _LoansPageState();
}

class _LoansPageState extends State<LoansPage> {
  int _selectedTabIndex = 0;
  double _selectedAmount = 0.0;
  String pin = "";
  double _limitAmount = 0.0;
  String _leftPanelStage = "slider";
  final TextEditingController _pinController = TextEditingController();
  String loanAmount = '';
  String loanStatus = '';
  String dueDate = '';
  String _interest = '0.0';
  String _loanTerm = 'N/A';
  String _dueDate = 'N/A';

  // Variables to hold loan details
  String _loanStatus = "N/A";
  String _principalAmount = "0.0";
  String _currentBalance = "0.0";
  String _date = "N/A";
  String _referenceId = "N/A";
  String _repaymentDate = "N/A";
  String _requestType = "N/A";
  String _mobileNumber = "N/A";
  String? _errorMessage; // Holds error messages for display

  String _currency = "N/A";

  @override
  void initState() {
    super.initState();
    _fetchLimitAmount();
    GlobalSessionManager().startMonitoring(context);
  }

  bool _isLoading = false; // Add to track loading state

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchLimitAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ElmsSSL elmsSSL = ElmsSSL();

    String? loginDetails = prefs.getString('loginDetails');
    if (loginDetails != null) {
      final parsedLogin = elmsSSL.cleanResponse(loginDetails);

      setState(() {
        _limitAmount =
            double.tryParse(parsedLogin['Data']['LimitAmount'].toString()) ??
                0.0;
        _selectedAmount = _limitAmount / 2;
        _loanStatus = parsedLogin['Data']['LoanStatus'] ?? "N/A";
        _principalAmount = parsedLogin['Data']['PrincipalAmount'] ?? "0.0";
        _currentBalance = parsedLogin['Data']['CurrentBalance'] ?? "0.0";
        _date = parsedLogin['Data']['Date'] ?? "N/A";
        _referenceId = parsedLogin['Data']['ReferenceId'] ?? "N/A";
        _repaymentDate = parsedLogin['Data']['RepaymentDate'] ?? "N/A";
        _requestType = parsedLogin['Data']['RequestType'] ?? "N/A";
        _mobileNumber = parsedLogin['Data']['MobileNumber'] ?? "N/A";
        _interest = parsedLogin['Data']['InterestRate'] ?? "0.0";
        _loanTerm = parsedLogin['Data']['LoanTermPeriod'] ?? "N/A";

        String dueDate = parsedLogin['Data']['DueDate'] ?? "N/A";
        if (dueDate != "") {
          _dueDate = dueDate;
        } else {
          _dueDate = "N/A";
        }

        // Fetch the currency
        _currency = parsedLogin['Data']['Currency'] ?? "N/A";
      });
    }
  }

  Future<void> _loadLoanDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loanDetails = prefs.getString('applyLoanDetails');
    if (loanDetails != null) {
      final parsedResponse = jsonDecode(loanDetails);
      setState(() {
        loanAmount = parsedResponse['Data']['LoanAmount'] ?? '';
        loanStatus = parsedResponse['Data']['LoanStatus'] ?? '';
        dueDate = parsedResponse['Data']['DueDate'] ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => GlobalSessionManager().updateActivity(context),
      child: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor:
            const Color(0xFF3C4B9D), // Match app's background color
        body: Stack(
          children: [
            // Background gradient
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
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _buildCardTabBar(),
                    const SizedBox(height: 30),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isWideScreen = constraints.maxWidth > 600;
                        if (isWideScreen) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: _buildLeftPanel(),
                              ),
                              Container(
                                width: 1,
                                color: Colors.white.withOpacity(0.4),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              Expanded(
                                flex: 1,
                                child: _buildRightPanel(),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLeftPanel(),
                              const SizedBox(height: 16),
                              _buildRightPanel(),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        if (constraints.maxWidth > 600) {
                          return const Footer();
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPanel() {
    switch (_leftPanelStage) {
      case "slider":
        return _buildSliderSection(
          "Loan Amount",
          "$_currency ${_selectedAmount.toStringAsFixed(0)}",
          "$_currency 0",
          "$_currency ${_limitAmount.toStringAsFixed(0)}",
        );
      case "confirmation":
        return _buildConfirmationScreen();
      case "pin":
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildPinScreen(), // Make sure this method is implemented
        );
      case "success":
        return _buildSuccessScreen();
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
          "$_currency $_principalAmount",
          "Current Balance",
          "$_currency $_currentBalance",
        ),
        const SizedBox(height: 16),
        _buildDetailsRow(
          "Due Date",
          _dueDate,
          "Loan Status",
          _loanStatus,
        ),
        const SizedBox(height: 16),
        _buildDetailsRow(
          "Loan Term",
          _loanTerm,
          "Interest Rate",
          _interest,
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
    bool isDisabled = _loanStatus == "PendingPayment"; // Check loan status
    double minAmount = isDisabled ? 0 : 1000; // Min is 0 if PendingPayment
    double maxAmount =
        isDisabled ? 0 : _limitAmount; // Max is 0 if PendingPayment
    double displayedAmount = isDisabled
        ? 0
        : _selectedAmount; // Selected amount is 0 if PendingPayment

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Min Label
            Text(
              "Min: $_currency ${minAmount.toStringAsFixed(0)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Max Label
            Text(
              "Max: $_currency ${maxAmount.toStringAsFixed(0)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Amount textview displayed above the slider
        Center(
          child: Text(
            "Selected Amount: $_currency ${displayedAmount.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Slider(
          value: displayedAmount,
          min: minAmount,
          max: maxAmount,
          onChanged: isDisabled
              ? null
              : (value) {
                  setState(() {
                    _selectedAmount = value;
                  });
                },
          activeColor: isDisabled ? Colors.grey : Colors.white,
          inactiveColor: Colors.white.withOpacity(0.3),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isDisabled
                ? null
                : () {
                    setState(() {
                      _leftPanelStage = "confirmation";
                    });
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: isDisabled ? Colors.grey : Colors.lightBlue,
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

  // Confirmation Screen
  Widget _buildConfirmationScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Centered Image
        Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/confirm.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(height: 25),

        // Confirmation Text
        const Text(
          "Confirmation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Loan Message
        const Text(
          "Please confirm your loan application.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 30),

        // Buttons Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Back Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _leftPanelStage = "slider"; // Go back to slider
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text(
                "Back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),

            // Confirm Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _leftPanelStage = "pin"; // Proceed to PIN entry
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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

  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Centered Image
          Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/succes.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Success Text
          const Text(
            "Loan Successful!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Confirmation Message
          const Text(
            "Your loan request has been approved.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),

          // Done Button
          ElevatedButton(
            onPressed: () {
              // Navigate to home screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
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
      ),
    );
  }

// Failure Screen
  Widget _buildFailureScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Centered Image
        Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/failed.png'),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(height: 25),

        // Failed Text
        const Text(
          "Failed!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),

        // Failure Message
        const Text(
          "Your loan request has been rejected.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),

        // Status Card
        const Card(
          color: Color(0xFF4C6DB2),
          margin: EdgeInsets.only(top: 16),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Unfortunately, we could not approve your loan request at this time. Please try again later.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Done Button
        ElevatedButton(
          onPressed: () {
            // Navigate to the home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
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

  // PIN Entry Screen
  Widget _buildPinScreen() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the size of the image based on screen width
        double imageSize = constraints.maxWidth > 600 ? 250 : 150;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Responsive Centered Image
            Container(
              width: imageSize,
              height: imageSize,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pin.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Confirmation Text
            const Text(
              "Enter PIN",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Instruction Text
            const Text(
              "Please enter your PIN to \n complete loan request.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),

            // PIN Circles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: index < _pinController.text.length
                        ? Colors.lightBlue
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.lightBlue),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Dial Pad with Backspace
            _buildDialPad(),

            const SizedBox(height: 20),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Back Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _leftPanelStage =
                          "confirmation"; // Go back to confirmation
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: Colors.white), // White border
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Confirm Payment Button
                ElevatedButton(
                  onPressed: () async {
                    String pin = _pinController.text.trim();

                    // Validate PIN
                    if (pin.isEmpty || pin.length != 4) {
                      _showErrorDialog("Please enter a valid 4-digit PIN.");
                      return;
                    }

                    setState(() => _isLoading = true); // Show loading spinner

                    try {
                      // ElmsSSL Logic
                      ElmsSSL elmsSSL = ElmsSSL();
                      String result = await elmsSSL.applyLoan(
                          _selectedAmount.toString(), pin);
                      Map<String, dynamic> resultMap = jsonDecode(result);

                      // Navigate to Success or Failure based on result
                      if (resultMap['status'] == 'success') {
                        setState(() => _leftPanelStage = "success");
                      } else {
                        setState(() => _leftPanelStage = "failure");
                      }
                    } catch (e) {
                      _showErrorDialog('An error occurred: $e');
                    } finally {
                      setState(
                          () => _isLoading = false); // Hide loading spinner
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            if (_isLoading) const SizedBox(height: 20),
            if (_isLoading) const CircularProgressIndicator(),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDialPad() {
    List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    return Column(
      children: [
        for (int i = 0; i < 3; i++) // Rows for numbers 1-9
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (j) => _buildDialButton(numbers[i * 3 + j]),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 80), // Placeholder for alignment
            _buildDialButton(0), // Zero in the middle
            _buildBackspaceButton(), // Backspace on the right
          ],
        ),
      ],
    );
  }

  Widget _buildDialButton(int number) {
    return GestureDetector(
      onTap: () {
        if (_pinController.text.length < 4) {
          setState(() {
            _pinController.text += number.toString();
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.lightBlue, width: 1.5),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: () {
        if (_pinController.text.isNotEmpty) {
          setState(() {
            _pinController.text = _pinController.text
                .substring(0, _pinController.text.length - 1);
          });
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.lightBlue, width: 1.5),
        ),
        child: const Center(
          child: Icon(
            Icons.backspace,
            color: Colors.lightBlue,
            size: 24,
          ),
        ),
      ),
    );
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
          _buildCardTab('Home', 2),
        ],
      ),
    );
  }

  Widget _buildCardTab(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoansPage(),
            ),
          ).then((_) {
            // Reset selected index on returning to this page
            setState(() {
              _selectedTabIndex = -1;
            });
          });
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyLoansPage(),
            ),
          ).then((_) {
            // Reset selected index on returning to this page
            setState(() {
              _selectedTabIndex = -1;
            });
          });
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ).then((_) {
            // Reset selected index on returning to this page
            setState(() {
              _selectedTabIndex = -1;
            });
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white, // Always white background
          borderRadius: BorderRadius.circular(10),
          // No border or outline
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black, // Black text for better readability on white
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
