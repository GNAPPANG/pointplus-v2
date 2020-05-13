import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
//  SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  get data => null;

  checklogin() async {
    FirebaseAuth.instance.currentUser().then((user) {
      print('user: $user');

//      if (user != null) {
//        var u = user.uid;

//        Firestore.instance
//            .collection('accounts')
//            .where('uid', isEqualTo: user.uid)
//            .where('role', isEqualTo: 'store')
//            .where('status', isEqualTo: 'a')
//            .getDocuments()
//            .then((value) {
//              print('storesssss');
//          Navigator.pushReplacementNamed(context, '/store');
//        }).catchError((e){
//            print('not improve');
//        });


//        if(
//          Firestore.instance
//            .collection('accounts')
//            .where('uid', isEqualTo: user.uid)
//            .where('role', isEqualTo: 'store')
//            .where('status', isEqualTo: 'a')
//            .
//        ){
//
//        }
//      } else {
//        Navigator.pushReplacementNamed(context, '/login');
//      }

      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      else {
        FirebaseAuth.instance.currentUser().then((user) {
          Firestore.instance
              .collection('accounts')
              .where('uid', isEqualTo: user.uid)
              .getDocuments()
              .then((doc) {
            if (doc.documents[0].exists) {
              if (doc.documents[0].data['role'] == 'user') {
                Navigator.pushReplacementNamed(context, '/user');
              } else {
                if(doc.documents[0].data['status'] == 'a'){
                  Navigator.pushReplacementNamed(context, '/store');
                }
                print('no approve');
                Navigator.pushReplacementNamed(context, '/login');
              }
            }
          });
        });

      }
    });
  }

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Visibility(
          visible: true,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
