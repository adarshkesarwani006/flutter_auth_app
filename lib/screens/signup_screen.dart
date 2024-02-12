// Import necessary packages and files
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../reusable_widgets/reusable_widget.dart'; // Import reusable widgets
import '../utils/colors_utils.dart';
import 'home_screen.dart'; // Import color utility functions

// Define SignUpScreen widget
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState(); // Create state for SignUpScreen
}

// Define state for SignUpScreen
class _SignUpScreenState extends State<SignUpScreen> {
  // Define controllers for text fields
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        // Styling for the background gradient
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("8a5b40"),
              hexStringToColor("fd7e14"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                // Text field for username
                reusableTextField("Enter UserName", Icons.person_outline, false, _userNameTextController),
                const SizedBox(height: 20),
                // Text field for email
                reusableTextField("Enter Email Id", Icons.person_outline, false, _emailTextController),
                const SizedBox(height: 20),
                // Text field for password
                reusableTextField("Enter Password", Icons.lock_outlined, true, _passwordTextController),
                const SizedBox(height: 20),
                // Button for signing up
                firebaseUIButton(context, "Sign Up", () {
                  String email = _emailTextController.text.trim();
                  String password = _passwordTextController.text.trim();

                  if (email.isEmpty) {
                    // Show toast if email field is empty
                    Fluttertoast.showToast(
                      msg: "Please enter an email address",
                      gravity: ToastGravity.TOP,
                    );
                    return;
                  }

                  if (password.isEmpty) {
                    // Show toast if password field is empty
                    Fluttertoast.showToast(
                      msg: "Please enter a password",
                      gravity: ToastGravity.TOP,
                    );
                    return;
                  }

                  // Continue with sign-up process
                  FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
                    // Show success toast
                    Fluttertoast.showToast(
                      msg: "Created New Account",
                      gravity: ToastGravity.TOP,
                      backgroundColor: Colors.green,
                    );
                    // Navigate to home screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }).catchError((error) {
                    // Show error message in a Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Error ${error.toString()}"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
