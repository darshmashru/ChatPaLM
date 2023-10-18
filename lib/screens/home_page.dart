import 'package:ChatPaLM/screens/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ChatPaLM/widgets/api_integration_widget.dart';
import 'package:ChatPaLM/screens/LoginOrRegister.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the current brightness mode is dark
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final user = FirebaseAuth.instance.currentUser!;
    void signUserOut() async {
      await FirebaseAuth.instance.signOut();
    }

    String userEmailString =
        FirebaseAuth.instance.currentUser!.email!.toString();

    return MaterialApp(
      theme: ThemeData(
        // Define the primary color and text themes for dark mode
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline6: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 22.0),
            child: Image.asset(
              "lib/assets/logos/image 7.png",
              height: 50,
            ),
          ),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              },
              icon: const Padding(
                padding: EdgeInsets.only(right: 200.0, top: 10.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
              child: Text(
                "Hello $userEmailString!",
                style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Explore and work with the PaLM API!", // Add your subheading text here
                style: TextStyle(fontSize: 18.0, color: Colors.white),
                textAlign: TextAlign.left,
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: ApiIntegrationWidget(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              gap: 10,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              padding: EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
