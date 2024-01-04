import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadNGODataPage extends StatefulWidget {
  const UploadNGODataPage({Key? key}) : super(key: key);

  @override
  _UploadNGODataPageState createState() => _UploadNGODataPageState();
}

class _UploadNGODataPageState extends State<UploadNGODataPage> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imgURLController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _imgURLController.dispose();
    super.dispose();
  }

  void _uploadNGOData() async {
    try {
      await _firestore.collection('ngo').add({
        'name': _nameController.text,
        'img': _imgURLController.text,
      });
      // Clear text fields after successful upload
      _nameController.clear();
      _imgURLController.clear();
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(width: 3),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(child: Text("GAIA'S TOUCH",style: TextStyle(fontFamily: 'Habibi'),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'NGO Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _imgURLController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadNGOData,
              child: Text('Upload Data'),
            ),
          ],
        ),
      ),
    );
  }
}
