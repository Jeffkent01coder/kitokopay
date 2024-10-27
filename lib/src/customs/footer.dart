import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF3C4B9D), // Background color
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // First column: Logo
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              Image.asset(
                'assets/images/Kitokopaylogo.png', // Replace with your logo path
                width: 150, // Adjust size as needed
                height: 50,
              ),
            ],
          ),

          // Second column: Company
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8), // Spacing between title and items
              Text(
                'About Us',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Get In Touch',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'FAQs',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          // Third column: Resources
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resources',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8), // Spacing between title and items
              Text(
                'Testimonials',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'How it works',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Blog',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          // Fourth column: Socials
          Column(
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
              const SizedBox(height: 8), // Spacing between title and icons
              Row(
                children: [
                  // Facebook icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.white,
                    ),
                  ),
                  // Instagram icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons
                          .camera_alt, // Replace with the appropriate Instagram icon
                      color: Colors.white,
                    ),
                  ),
                  // LinkedIn icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.linked_camera, // Replace with the LinkedIn icon
                      color: Colors.white,
                    ),
                  ),
                  // X (Twitter) icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons
                          .clear, // Replace with the appropriate X (Twitter) icon
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
