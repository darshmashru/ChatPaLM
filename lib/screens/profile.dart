import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../Components/BottomNavigationBarWidget.dart';
import 'LoginOrRegister.dart';

String apiKey = dotenv.env['PALM_API_KEY']!;
class Profile extends StatelessWidget {
  const Profile({super.key});

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MaterialApp(
      theme: ThemeData(
        // Define the primary color and text themes for dark mode
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          titleLarge:
              TextStyle(color: isDarkMode ? Colors.white : Colors.black),
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
                signUserOut();
                Navigator.push(
                  context,
                  // MaterialPageRoute(builder: (context) => AuthPage()),
                  MaterialPageRoute(
                      builder: (context) => const LoginOrRegisterPage()),
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
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "First Name",
                    style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                  ),
                  Text(
                    "First Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "API Key",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "Hidden",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    // onChanged: (value) {
                    //   apiKey = value;
                    // },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Show input dialog
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Enter API Key"),
                        content: TextField(
                          onChanged: (value) {
                            apiKey = value;
                            print(apiKey);
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    }
                );
              },
              child: const Text("Update API Key"),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}
