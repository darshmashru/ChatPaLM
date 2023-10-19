import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../Components/BottomNavigationBarWidget.dart';
import 'LoginOrRegister.dart';

String apiKey = dotenv.env['PALM_API_KEY']!;

final _obscureTextNotifier = ValueNotifier<bool>(true);
final TextEditingController _apiTextController = TextEditingController();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _obscureText = false;
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "API Key",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _apiTextController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _apiTextController.text.isNotEmpty
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                            print(_obscureTextNotifier.value);
                            print(_apiTextController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update API Key"),
              onPressed: () {
                setState(
                  () {
                    apiKey = _apiTextController.text;
                    print(apiKey);
                  },
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}
