import 'package:ChatPaLM/screens/home_page.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceAround, // This will center the icons horizontally
        crossAxisAlignment:
            CrossAxisAlignment.center, // This will center the icons vertically
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home,
              size: 40,
            ),
            onPressed: () {
              HomePage();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "lib/assets/logos/image 7.png", // Replace with your logo
              height: 50, // Adjust height as needed
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 50,
            ),
            onPressed: () {
              // Handle navigation to Account Information screen
            },
          ),
        ],
      ),
    );
  }
}
