import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();

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
    return Scaffold(
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
        shape: Border(
          bottom: BorderSide(width: 3),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(child: Text("GAIA'S TOUCH",style: TextStyle(fontFamily: 'Habibi'),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _itemController,
              decoration: InputDecoration(
                labelText: 'Items Requested',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _imgController,
              decoration: InputDecoration(
                labelText: 'Image Link',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _uploadDetails();
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadDetails() async {
    final name = _nameController.text.trim();
    final desc = _descController.text.trim();
    final item = _itemController.text.trim();
    final img = _imgController.text.trim();

    try {
      await _firestore.collection('requests').add({
        'name': name,
        'desc': desc,
        'item': item,
        'img': img,
      });
      // Clear text fields after successful upload
      _nameController.clear();
      _descController.clear();
      _itemController.clear();
      // Optionally, show a success message or navigate to another page
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Details uploaded successfully'),
      ));
    } catch (e) {
      print('Error uploading details: $e');
      // Handle upload errors here
    }
  }
}
