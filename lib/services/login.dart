import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/join/login_page.dart';

class Login {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/'));
  }

  singInAuth(String userid, BuildContext context) {
    print('login: $userid');

    _auth.currentUser().then((user) {
      Firestore.instance
          .collection('accounts')
          .where('uid', isEqualTo: userid)
          .getDocuments()
          .then((doc) {
        if (doc.documents[0].exists) {
          var dd = doc.documents[0];
          if (doc.documents[0].data['role'] == 'user') {
            Navigator.pushReplacementNamed(context, '/user');
          } else {
            var st = doc.documents[0].data['status'];
            if (st == 'a') {
              print('appr: $st');
              Navigator.pushReplacementNamed(context, '/store');
            }else{
              print('noappr: $st');
              print('no approve');
              // alert
            }


          }
        }
      });
    });
  }
}
