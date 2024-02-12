import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication package
import 'package:flutter/material.dart'; // Flutter material package

import '../reusable_widgets/reusable_widget.dart'; // Import reusable widgets
import '../utils/colors_utils.dart'; // Import color utility functions

// Define ResetPassword widget
class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordState createState() => _ResetPasswordState(); // Create state for ResetPassword
}

// Define state for ResetPassword
class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailTextController = TextEditingController(); // Controller for email text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password", // AppBar title
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
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
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Email Id", // Text field hint
                  Icons.person_outline, // Icon for the text field
                  false, // Obscure text field
                  _emailTextController, // Controller for the text field
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Reset Password", () {
                  // Firebase function to send password reset email
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _emailTextController.text)
                      .then((value) => Navigator.of(context).pop()); // Close the screen after sending reset email
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
