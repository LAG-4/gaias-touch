import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firebase.dart';

class SettingsUser extends StatelessWidget {
  const SettingsUser({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _getUserInfo() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userInfo = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Return user information excluding the 'isAdmin' field
        Map<String, dynamic> userData = userInfo.data() as Map<String, dynamic>;
        userData.remove('isAdmin');

        return userData;
      }
      return {};
    } catch (e) {
      print('Error fetching user information: $e');
      return {};
    }
  }

  Future<Map<String, int>> fetchData() async {
    FirebaseService firebaseService = FirebaseService();

    List<String> usersID = await firebaseService.getAllUsers();
    Map<String, int> dict = {};
    // Use arrayData as needed
    print('User Data: $usersID');
    for (String user in usersID) {
      String name = await firebaseService.getUserName(user);
      int pts = await firebaseService.getUserPoint(user);
      dict[name] = pts;
    }
    print(dict);
    var sortedEntries = dict.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    var sortedMap = Map.fromEntries(sortedEntries);

    print(sortedMap);
    return sortedMap;
  }
    Future<void> _signOut(BuildContext context) async {
      try {
        await FirebaseAuth.instance.signOut();
        // Navigate back to the login or initial screen after logout
        Navigator.of(context).popUntil((route) => route.isFirst);
      } catch (e) {
        print('Error signing out: $e');
      }
    }


    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Row(
                children: [
                  Text('Logout'),
                  IconButton(onPressed: () {
                    _signOut(context);
                  }, icon: Icon(Icons.logout_rounded)),
                ],
              )
            ],
            shape: const Border(
              bottom: BorderSide(width: 3),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Center(child: const Text(
                "GAIA'S TOUCH", style: TextStyle(fontFamily: 'Habibi'))),
          ),
          body: FutureBuilder<Map<String, dynamic>>(
            future: _getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData) {
                Map<String, dynamic> userInfo = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [

                      Card(
                          margin: EdgeInsets.all(16.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'LEADERBOARD', style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'InterBlack'),),
                              ],
                            ),
                          )),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Position', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Inter')),
                          Text('Name', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Inter'),),
                          Text('Points', style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Inter'),),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        1', style: TextStyle(fontSize: 20),),
                          Text('Aryan', style: TextStyle(fontSize: 20),),
                          Text('100', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        2', style: TextStyle(fontSize: 20),),
                          Text('Nayan', style: TextStyle(fontSize: 20),),
                          Text('90', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        3', style: TextStyle(fontSize: 20),),
                          Text('Anas', style: TextStyle(fontSize: 20),),
                          Text('70', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        4', style: TextStyle(fontSize: 20),),
                          Text('RK', style: TextStyle(fontSize: 20),),
                          Text('60', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        5', style: TextStyle(fontSize: 20),),
                          Text('Krishna', style: TextStyle(fontSize: 20),),
                          Text('50', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        6', style: TextStyle(fontSize: 20),),
                          Text('Tanmay', style: TextStyle(fontSize: 20),),
                          Text('40', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        7', style: TextStyle(fontSize: 20),),
                          Text('Tushar', style: TextStyle(fontSize: 20),),
                          Text('30', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        8', style: TextStyle(fontSize: 20),),
                          Text('Pranav', style: TextStyle(fontSize: 20),),
                          Text('20', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('        9', style: TextStyle(fontSize: 20),),
                          Text('Ashwin', style: TextStyle(fontSize: 20),),
                          Text('10', style: TextStyle(fontSize: 20),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('       10', style: TextStyle(fontSize: 20),),
                          Text('Aman', style: TextStyle(fontSize: 20),),
                          Text('0', style: TextStyle(fontSize: 20),),
                        ],
                      ),

                    ],
                  ),
                );
              }

              return const Center(child: Text('No user information available'));
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

