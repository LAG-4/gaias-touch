import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc/firebase.dart';
import 'package:upi_india/upi_india.dart';

class NGODetailsPage extends StatefulWidget {
  final String name;

  NGODetailsPage({required this.name});

  @override
  State<NGODetailsPage> createState() => _NGODetailsPageState();
}

class _NGODetailsPageState extends State<NGODetailsPage> {
  final UpiIndia _upiIndia = UpiIndia();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UpiResponse> initiateTransaction(String upi) async {
    return _upiIndia.startTransaction(
      app: UpiApp.googlePay,
      receiverUpiId: upi,
      receiverName: 'LAG',
      transactionRefId: 'TestingUpi',
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Details'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('ngo')
            .where('name', isEqualTo: widget.name)
            .get()
            .then((querySnapshot) => querySnapshot.docs.first),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          String desc = data['desc'] ?? '';
          String upi = data['upi'] ?? '';

          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${widget.name}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(),
                        Text(
                          'Description:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '$desc',
                          style: TextStyle(fontSize: 16),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () async {
                            try {
                              await initiateTransaction(upi);
                            } catch (e) {
                              print('Error: $e');
                              // Handle transaction initiation error
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'UPI Id:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                upi,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {

                      String user = FirebaseService().getCurrentUser() as String;
                      int currPts = FirebaseService().getUserPoint(user) as int;
                      currPts = currPts + 10;
                      print("he;;p");
                      await _firestore.collection('users').doc(user).update({
                        'points': currPts,
                      });
                      await initiateTransaction(upi);
                    } catch (e) {
                      print('Error: $e');
                      // Handle transaction initiation error
                    }
                  },
                  child: Text("Pay Via GPay"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
