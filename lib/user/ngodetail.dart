import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:upi_india/upi_india.dart';

class NGODetailsPage extends StatefulWidget {
  final String name;

  NGODetailsPage({required this.name});

  @override
  State<NGODetailsPage> createState() => _NGODetailsPageState();
}

class _NGODetailsPageState extends State<NGODetailsPage> {
  final UpiIndia _upiIndia = UpiIndia();

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name: ', style: TextStyle( fontWeight: FontWeight.bold),),
                    Text(
                      '${widget.name}',

                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Description: ', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                      '$desc',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    try {
                      await initiateTransaction(upi);
                    } catch (e) {
                      print('Error: $e');
                      // Handle transaction initiation error
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('UPI Id: ', style: TextStyle(fontWeight: FontWeight.bold),),
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
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async {
                  try {
                    await initiateTransaction(upi);
                  } catch (e) {
                    print('Error: $e');
                    // Handle transaction initiation error
                  }
                }, child: Text("Pay Via GPay"))
              ],
            ),
          );
        },
      ),
    );
  }
}
