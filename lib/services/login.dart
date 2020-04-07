import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/join/home.dart';
import 'package:point_plus_v2/join/login_page.dart';
import 'package:point_plus_v2/store/homestore.dart';

class Login {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  singOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/'));
  }

  singInAuth(BuildContext context) {
    _auth.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .getDocuments()
          .then((doc) {
        if (doc.documents[0].exists) {
          if (doc.documents[0].data['role'] == 'user') {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomestorePage()));
          }
        }
      });
    });
  }
}
