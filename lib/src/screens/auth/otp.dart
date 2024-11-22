import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Left Column (Image)
              if (constraints.maxWidth > 600)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black,
                    child: Image.asset(
                      'assets/images/otp.png', // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              // Right Column (OTP Form)
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo
                          Center(
                            child: Image.asset(
                              'assets/images/Kitokopaylogo.png',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          // OTP Text
                          const Text(
                            "OTP",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Subtext
                          Text(
                            "Enter OTP sent to you",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Text Input Field
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter OTP",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 24),
                          // Send Button
                        Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Add your button action here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                padding: EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: MediaQuery.of(context)
                                              .size
                                              .width >
                                          600
                                      ? 200 // Wider padding for larger screens
                                      : 50, // Narrower padding for smaller screens
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                "Send",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
