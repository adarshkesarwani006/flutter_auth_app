import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication package
import 'package:flutter/material.dart'; // Flutter material package
import 'package:flutter_app/screens/reset_password.dart'; // Import ResetPassword screen
import 'package:flutter_app/screens/signup_screen.dart'; // Import SignUpScreen screen
import '../reusable_widgets/reusable_widget.dart'; // Import reusable widgets
import '../utils/colors_utils.dart'; // Import color utility functions
import 'home_screen.dart'; // Import HomeScreen screen

// Define SignInScreen widget
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignInScreenState createState() => _SignInScreenState(); // Create state for SignInScreen
}

// Define state for SignInScreen
class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController(); // Controller for password text field
  final TextEditingController _emailTextController = TextEditingController(); // Controller for email text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logo1.png"), // Logo widget
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Enter UserName", Icons.person_outline, false,
                    _emailTextController), // Text field for email
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Enter Password", Icons.lock_outline, true,
                    _passwordTextController), // Text field for password
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context), // Forget password button
                firebaseUIButton(context, "Sign In", () {
                  String email = _emailTextController.text.trim();
                  String password = _passwordTextController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter both email and password"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return; // Do not proceed further
                  }

                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: email, password: password)
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  }).catchError((error, stackTrace) {
                    // print("Error ${error.toString()}");
                    String errorMessage = "An error occurred. Please try again.";

                    // Check specific error codes and set appropriate error messages
                    if (error is FirebaseAuthException) {
                      if (error.code == 'invalid-email') {
                        errorMessage = "Invalid email format. Please enter a valid email.";
                      } else if (error.code == 'invalid-credential') {
                        errorMessage = "Invalid password. Please check your password.";
                      }
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  });

                }),
                signUpOption() // Sign up option
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget for the sign up option
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  // Widget for the forget password button
  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
