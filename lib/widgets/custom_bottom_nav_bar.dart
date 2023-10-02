import 'package:ChatPaLM/screens/home_page.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              HomePage();
            },
          ),
          const Spacer(), // Add spacer to separate icons and logo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "lib/assets/logos/image 7.png", // Replace with your logo
              height: 24, // Adjust height as needed
            ),
          ),
          const Spacer(), // Add spacer to separate icons and logo
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Handle navigation to Account Information screen
            },
          ),
        ],
      ),
    );
  }
}