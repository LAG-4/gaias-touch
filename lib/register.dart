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
  late TextEditingController _nameController;
  late TextEditingController _locController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameController = TextEditingController();
    _locController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _locController.dispose();
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
    final String name = _nameController.text.trim();
    final String loc = _locController.text.trim();

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
          'name': name,
          'loc': loc,
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
    return SafeArea(
      child: Scaffold(
        // Scaffold widget configuration...
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 150,
                  width: 300,
                  child: Center(child: Text('REGISTER',style: TextStyle(color: Colors.black,fontSize: 40,fontFamily: 'Habibi'),)),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Container(
                // Container widget configuration...
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Replace IconButton with Icon for Password
                            Icon(Icons.person_2_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            // Password text field
                            Expanded(
                              child: TextFormField(
                                controller: _nameController,

                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: TextStyle(color: Colors.red),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Replace IconButton with Icon for Password
                            Icon(Icons.person_2_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            // Password text field
                            Expanded(
                              child: TextFormField(
                                controller: _locController,

                                decoration: InputDecoration(
                                  hintText: 'State',
                                  hintStyle: TextStyle(color: Colors.red),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Replace IconButton with Icon for Password
                            Icon(Icons.email_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            // Password text field
                            Expanded(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(color: Colors.red),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                     SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Replace IconButton with Icon for Password
                            Icon(Icons.lock_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            // Password text field
                            Expanded(
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(color: Colors.red),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Replace IconButton with Icon for Password
                            Icon(Icons.lock_rounded, color: Colors.red),
                            SizedBox(width: 10),
                            // Password text field
                            Expanded(
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(color: Colors.red),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),


                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(child:Text('Register',style: TextStyle(color: Colors.white),),
                              onPressed: _registerWithEmailAndPassword,
                            ),
                          ],
                        ),

                      ),

                      const SizedBox(height: 15),
                      TextButton(
                        // TextButton configuration...
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Already have an account? Log In',style: TextStyle(color: Colors.red,fontFamily: 'InterBlack'),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
