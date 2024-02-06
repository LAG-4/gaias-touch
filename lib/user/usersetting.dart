import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../firebase.dart';

class SettingsUser extends StatelessWidget {
  const SettingsUser({Key? key}) : super(key: key);
  _launchURL1() async {
    const url = 'http://10.56.8.111:8501';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchURL2() async {
    const url = 'https://we-chat-sinisterdaddys-projects.vercel.app/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                IconButton(
                  onPressed: () {
                    _signOut(context);
                  },
                  icon: Icon(Icons.logout_rounded),
                ),
              ],
            )
          ],
          shape: const Border(
            bottom: BorderSide(width: 3),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
            child: const Text(
              "GAIA'S TOUCH",
              style: TextStyle(fontFamily: 'Habibi'),
            ),
          ),
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
                    ElevatedButton(onPressed: (){
                      _launchURL2();
                    }, child: Text('Chat With An NGO')),
                    ElevatedButton(onPressed: (){
                      _launchURL1();
                    }, child: Text('Chat With An AI')),
                    Card(
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'LEADERBOARD',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'InterBlack',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ListView.builder for the leaderboard
                    // ListView.builder for the leaderboard
                    // ListView.builder for the leaderboard
                    Expanded(
                      child: FutureBuilder<Map<String, int>>(
                        future: fetchData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasData) {
                            Map<String, int> leaderboardData = snapshot.data!;
                            return Column(
                              children: [
                                // Header row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Rank', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Points', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                // Divider line
                                Divider(),
                                // Data rows
                                ...leaderboardData.entries.map((entry) {
                                  final userName = entry.key;
                                  final userPoints = entry.value;
                                  final rank = leaderboardData.keys.toList().indexOf(userName) + 1;

                                  return ListTile(
                                    title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('$rank'),
                                        Text('$userName'),
                                        Text('$userPoints pts'),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          }

                          return const Center(
                            child: Text('No leaderboard data available'),
                          );
                        },
                      ),
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
