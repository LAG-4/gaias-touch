import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gdsc/admin/adminnavbar.dart';
import 'package:gdsc/register.dart';

import 'user/navbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Signed in successfully
      User? user = userCredential.user;
      if (user != null) {
        // Fetch user details from Firestore
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        bool isAdmin = userData['isAdmin'] ?? false;
        if (isAdmin) {
          // Redirect admin user
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AdminNav()),
          );
        } else {
          // Redirect non-admin user
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DamnTime()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      // Handle authentication exceptions
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 150,
                    width: 300,
                    child: Center(child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('GAIAS',style: TextStyle(color: Colors.black,fontSize: 40,fontFamily: 'Habibi'),),
                        Text('TOUCH',style: TextStyle(color: Colors.black,fontSize: 40,fontFamily: 'Habibi'),),
                      ],
                    )),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 300, // Set the desired width
                    height: 300, // Set the desired height
                    child: Image.asset(
                      'assets/img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replace IconButton with Icon for Email
                        Icon(Icons.email, color: Colors.red),
                        SizedBox(width: 10),
                        // Email text field
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
                ),

                SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Replace IconButton with Icon for Password
                        Icon(Icons.lock, color: Colors.red),
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
                ),

                SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(child:Text('Sign In',style: TextStyle(color: Colors.white),),
                          onPressed: _signInWithEmailAndPassword,
                        ),
                      ],
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(child:Text('Register',style: TextStyle(color: Colors.white),),
                          onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
                          },
                        ),
                      ],
                    ),

                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
