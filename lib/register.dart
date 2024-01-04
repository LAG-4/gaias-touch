import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerWithEmailAndPassword() async {
    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final String email = _emailController.text.trim();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Registration successful, save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': email,
          'isAdmin': false,
          'points': 0,
        });

        // Navigate to the login screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    } catch (e) {
      print('Failed to register: $e');
      // Handle registration failures, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold widget configuration...
      body: SingleChildScrollView(
        child: Container(
          // Container widget configuration...
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              // Email TextField
              TextField(
                // TextField configuration...
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              // Password TextField
              TextField(
                // TextField configuration...
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 10),
              // Confirm Password TextField
              TextField(
                // TextField configuration...
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                // ElevatedButton configuration...
                onPressed: () {
                  _registerWithEmailAndPassword();
                },
                child: const Text('REGISTER'),
              ),
              const SizedBox(height: 15),
              TextButton(
                // TextButton configuration...
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Already have an account? Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
