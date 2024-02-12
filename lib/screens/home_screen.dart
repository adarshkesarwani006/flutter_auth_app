import 'dart:convert'; // Importing dart:convert library for JSON encoding and decoding
import 'package:http/http.dart' as http; // Importing http package for making HTTP requests
import 'package:firebase_auth/firebase_auth.dart'; // Importing firebase_auth package for authentication
import 'package:flutter/material.dart'; // Importing material package for Flutter UI components
import 'package:fluttertoast/fluttertoast.dart'; // Importing fluttertoast package for displaying toast messages
import 'package:flutter_app/screens/signin_screen.dart'; // Importing signin_screen.dart for navigation

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> _bitcoinData = {}; // Variable to store Bitcoin data

  @override
  void initState() {
    super.initState();
    _fetchBitcoinData(); // Call method to fetch Bitcoin data when the screen initializes
  }

  // Method to fetch Bitcoin data from API
  Future<void> _fetchBitcoinData() async {
    final response = await http.get(Uri.parse('https://api.coindesk.com/v1/bpi/currentprice.json')); // Make HTTP GET request
    if (response.statusCode == 200) {
      // If request is successful (status code 200), update Bitcoin data
      setState(() {
        _bitcoinData = json.decode(response.body); // Decode JSON response and store it in _bitcoinData
      });
    } else {
      throw Exception('Failed to load Bitcoin data'); // If request fails, throw an exception
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Bitcoin Price",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: _bitcoinData.isEmpty // Check if Bitcoin data is empty
          ? const Center(child: CircularProgressIndicator()) // If empty, show loading indicator
          : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.brown], // colors 
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Fluttertoast.showToast(
                      msg: "Signed Out",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()), // Navigate to SignInScreen
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.black,
                  side: const BorderSide(color: Colors.white, width: 1), // Add white border
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Bitcoin Data",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Display Bitcoin data
              ListTile(
                tileColor: Colors.transparent,
                title: const Text(
                  "Time",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Updated: ${_bitcoinData['time']['updated']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Updated ISO: ${_bitcoinData['time']['updatedISO']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Updated UK: ${_bitcoinData['time']['updateduk']}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              ListTile(
                tileColor: Colors.transparent,
                title: const Text(
                  "Disclaimer",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  _bitcoinData['disclaimer'],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                tileColor: Colors.transparent,
                title: const Text(
                  "Chart Name",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  _bitcoinData['chartName'],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                tileColor: Colors.transparent,
                title: const Text(
                  "BPI",
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var currency in _bitcoinData['bpi'].keys)
                      ListTile(
                        title: Text(
                          currency,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Code: ${_bitcoinData['bpi'][currency]['code']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Symbol: ${_bitcoinData['bpi'][currency]['symbol']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Rate: ${_bitcoinData['bpi'][currency]['rate']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Description: ${_bitcoinData['bpi'][currency]['description']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              "Rate Float: ${_bitcoinData['bpi'][currency]['rate_float']}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
