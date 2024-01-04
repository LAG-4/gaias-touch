import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Text('Logout'),
                IconButton(onPressed: (){
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
          title: Center(child: const Text("GAIA'S TOUCH", style: TextStyle(fontFamily: 'Habibi'))),
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
                    Text('MY INFO',style: TextStyle(color: Colors.black, fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'InterBlack'),),
                    Expanded(
                      child: ListView(
                        children: userInfo.entries.map((entry) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${entry.key} : '.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Inter',fontSize: 20,color: Colors.black),),
                                Text(
                                  ' ${entry.value}',
                                  style: const TextStyle(fontSize: 20,fontFamily: 'Inter',color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
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

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      // Navigate back to the login or initial screen after logout
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
