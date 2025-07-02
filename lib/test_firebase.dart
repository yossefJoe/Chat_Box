import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/video_call_page.dart';

class AddCollectionPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addTestCollection() async {
    try {
      await firestore.collection('testCollection').add({
        'name': 'Test Name',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Document added!');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Collection Test'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await addTestCollection();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Document added to testCollection')),
                );
              },
              child: Text('Add Document'),
            ),
          ),
         
        ],
      ),
    );
  }
}
