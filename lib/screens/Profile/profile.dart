import 'package:ChatPaLM/env/env.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ChatPaLM/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

// API Key from Envied .env file
String apiKey = Env.palmApiKey;

// API Key from globals.dart
// String apiKey = PALM_API_KEY;

final _obscureTextNotifier = ValueNotifier<bool>(true);
final TextEditingController _apiTextController = TextEditingController();
final TextEditingController _nameTextController = TextEditingController();

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _obscureText = true;
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      USER_NAME_GLOBAL = prefs.getString('userName') ?? '';
    });
  }

  void _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', USER_NAME_GLOBAL);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 175,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _nameTextController,
                      // obscureText: _obscureText,
                      decoration: const InputDecoration(
                        fillColor: Color.fromRGBO(30, 30, 30, 1),
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(color: Colors.white),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 30, 30,
                                1), // Change the highlight color to teal
                            width: 2.0, // Adjust the border width as needed
                          ),
                        ),
                        filled: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email",
                    style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!.toString() ??
                        'N/A',
                    style: GoogleFonts.inter(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("API Key",
                      style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 175,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _apiTextController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(30, 30, 30, 1),
                        hintText: 'Enter API Key',
                        hintStyle: const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(30, 30, 30,
                                1), // Change the highlight color to teal
                            width: 2.0, // Adjust the border width as needed
                          ),
                        ),
                        filled: true,
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
            const SizedBox(height: 50),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(30, 30, 30, 1),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              child: const Text("Update Name"),
              onPressed: () {
                print("Old Name:$USER_NAME_GLOBAL");
                setState(() {
                  USER_NAME_GLOBAL = _nameTextController.text;
                  _saveName();
                });
                print("New Name:$USER_NAME_GLOBAL");
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(30, 30, 30, 1),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              child: const Text("Update API Key"),
              onPressed: () {
                print("Old API Key:$PALM_API_KEY");
                setState(
                  () {
                    apiKey = _apiTextController.text;
                    PALM_API_KEY = apiKey;
                    print("New API Key:$apiKey");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}