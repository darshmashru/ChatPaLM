import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ChatPaLM/widgets/api_integration_widget.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final user = FirebaseAuth.instance.currentUser!;
  // void signUserOut() async {
  //   await FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
    //   ),
    //   body: Center(child: Text("Welcome " + user.email!)),
    // );
    return MaterialApp(
      home: ApiIntegrationWidget(),
    );
  }
}
