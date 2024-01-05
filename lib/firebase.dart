
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getArrayData(String ngo) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('ngo')
          .doc(ngo)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('sdg')) {
          List<dynamic> dataArray = data['sdg'] ?? [];
          List<String> stringArray = dataArray.cast<String>();
          return stringArray;
        } else {
          print('Array field not found in the document');
          return [];
        }
      } else {
        print('Document does not exist');
        return [];
      }
    } catch (e) {
      print('Error retrieving data: $e');
      return [];
    }
  }
  Future<String> getNgoName(String ngo) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('ngo')
          .doc(ngo)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('name')) {
          String name = data['name'] ?? '';
          return name;
        } else {
          print('name field not found in the document');
          return '';
        }
      } else {
        print('Document does not exist');
        return '';
      }
    } catch (e) {
      print('Error retrieving data: $e');
      return '';
    }
  }
  Future<List<String>> getAllNgos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('ngo').get();

      List<String> ngos = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Assuming the NGO ID is stored as the document ID
        ngos.add(doc.id);
      }

      return ngos;
    } catch (e) {
      print('Error retrieving NGOs: $e');
      return [];
    }
  }
  Future<List<String>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();

      List<String> ngos = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Assuming the NGO ID is stored as the document ID
        ngos.add(doc.id);
      }

      return ngos;
    } catch (e) {
      print('Error retrieving Users: $e');
      return [];
    }
  }
  Future<int> getUserPoint(String user) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(user)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('points')) {
          int point = data['points'] ?? '';
          return point;
        } else {
          print('points field not found in the document');
          return 0;
        }
      } else {
        print('Document does not exist');
        return 0;
      }
    } catch (e) {
      print('Error retrieving data: $e');
      return 0;
    }
  }
  Future<String> getUserName(String user) async {
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('users')
          .doc(user)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('name')) {
          String name = data['name'] ?? '';
          return name;
        } else {
          print('name field not found in the document');
          return '';
        }
      } else {
        print('Document does not exist');
        return '';
      }
    } catch (e) {
      print('Error retrieving data: $e');
      return '';
    }
  }
}