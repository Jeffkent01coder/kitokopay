import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine layout style based on screen width
    final isSmallScreen = screenWidth < 600; // Adjust breakpoint as needed

    return Container(
      color: const Color(0xFF3C4B9D), // Background color
      padding: const EdgeInsets.all(16.0),
      child: isSmallScreen
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/images/Kitokopaylogo.png',
                  width: 150,
                  height: 50,
                ),
                const SizedBox(height: 16),

                // Company
                _buildColumn('Company', const [
                  'About Us',
                  'Get In Touch',
                  'FAQs',
                ]),

                const SizedBox(height: 16),

                // Resources
                _buildColumn('Resources', const [
                  'Testimonials',
                  'How it works',
                  'Blog',
                ]),

                const SizedBox(height: 16),

                // Socials
                _buildSocials(),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/images/Kitokopaylogo.png',
                  width: 150,
                  height: 50,
                ),

                // Company
                _buildColumn('Company', const [
                  'About Us',
                  'Get In Touch',
                  'FAQs',
                ]),

                // Resources
                _buildColumn('Resources', const [
                  'Testimonials',
                  'How it works',
                  'Blog',
                ]),

                // Socials
                _buildSocials(),
              ],
            ),
    );
  }

  // Helper to build columns with titles and items
  Widget _buildColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Text(
              item,
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  // Helper to build socials section
  Widget _buildSocials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Socials',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.facebook, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.linked_camera, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.clear, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
