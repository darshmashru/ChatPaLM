import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ChatPaLM/widgets/api_integration_widget.dart';
import 'package:ChatPaLM/widgets/custom_bottom_nav_bar.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final user = FirebaseAuth.instance.currentUser!;
  // void signUserOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

//   @override
//   Widget build(BuildContext context) {
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
//     //   ),
//     //   body: Center(child: Text("Welcome " + user.email!)),
//     // );
//     // return MaterialApp(
//     return Scaffold(
//       body: ApiIntegrationWidget(),
//       bottomNavigationBar: const CustomBottomNavBar(),
//     );
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to ChatPaLM!'),
        actions: [Icon(Icons.logout)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 64.0, left: 16.0, right: 16.0),
            child: Text(
              "Hello Darsh.", // ToDo: Change this so that it dynamically changes the username fetched from auth
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Explore and work with the PaLM API!", // Add your subheading text here
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: ApiIntegrationWidget(),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}