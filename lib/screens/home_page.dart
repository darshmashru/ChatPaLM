import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ChatPaLM/screens/profile.dart';
import 'package:ChatPaLM/widgets/api_integration_widget.dart';
import 'package:ChatPaLM/screens/LoginOrRegister.dart';
import 'package:ChatPaLM/widgets/BottomNavigationBarWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int myIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    void signUserOut() async {
      await FirebaseAuth.instance.signOut();
    }

    String userEmailString =
        FirebaseAuth.instance.currentUser!.email!.toString();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
        body: PageView(
          controller: _pageController,
          children: [
            buildHomePage(userEmailString),
            const Profile(),
          ],
          onPageChanged: (index) {
            setState(() {
              myIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          fixedColor: Colors.white,
          unselectedItemColor: Color.fromRGBO(149, 149, 149, 1),
          onTap: (index) {
            setState(() {
              myIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            });
          },
          currentIndex: myIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHomePage(String userEmailString) {
    return Column(
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
    );
  }
}
