import "package:ChatPaLM/Components/button.dart";
import "package:ChatPaLM/Components/squaretile.dart";
import "package:ChatPaLM/Components/textfield.dart";
import "package:ChatPaLM/screens/home_page.dart";
import "package:ChatPaLM/services/auth_service.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  final Function? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.deepPurple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  void signUserIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);

      // Redirect to the home_page.dart file
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'lib/assets/logos/PaLM Logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  "Welcome Back You've Have Been Missed !",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: emailController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('Or Continue With',
                          style: TextStyle(color: Colors.white)),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.6,
                        color: Colors.grey[400],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Squaretile(
                      imagePath: "lib/assets/images/google.png",
                      onTap: () => AuthService().signInWithGoogle(),
                    ),
                    SizedBox(width: 10),
                    Squaretile(
                      imagePath: "lib/assets/images/apple.png",
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap as void Function()?,
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
