import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
//  SplashScreen({Key key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user)  {
      print('user: $user');
      if(user == null){
        Navigator.pushReplacementNamed(context, '/login');
      }else{
        print('user: $user');
        FirebaseAuth.instance.currentUser().then((user){
          var role;
          Firestore.instance
                    .collection('users')
                    .where('uid', isEqualTo: user.uid)
                    .getDocuments()
                    .then((doc) {
                  if (doc.documents [0].exists) {
                    if (doc.documents[0].data['role'] == 'store') {
                      setState(()=> role = 'store' );
                    } else {
                      setState(()=> role = 'user' );
                    }
                  }
                });

          if(role == 'store'){
            Firestore.instance
                .collection('store')
                .where('uid', isEqualTo: user.uid)
                .getDocuments()
                .then((doc) {
              if (doc.documents [0].exists) {
                if (doc.documents[0].data['role'] == 'store') {
                  Navigator.pushReplacementNamed(context, '/store');
                }
              }
            });
          }else{
            Firestore.instance
                .collection('users')
                .where('uid', isEqualTo: user.uid)
                .getDocuments()
                .then((doc) {
              if (doc.documents [0].exists) {
                if (doc.documents[0].data['role'] == 'user') {
                  Navigator.pushReplacementNamed(context, '/user');
                } else {
                  setState(()=> role = 'user' );
                }
              }
            });
          }




        });
      }
    });
//    FirebaseAuth.instance.currentUser().then((user) => {
//      print('user: $user')
////          if (user == null)
////            {Navigator.pushReplacementNamed(context, '/login')}
////          else
////            {
////              FirebaseAuth.instance.currentUser().then((user) {
////                Firestore.instance
////                    .collection('users')
////                    .where('uid', isEqualTo: user.uid)
////                    .getDocuments()
////                    .then((doc) {
////                  if (doc.documents [0].exists) {
////                    if (doc.documents[0].data['role'] == 'user') {
////                      Navigator.pushReplacementNamed(context, '/user');
////                    } else {
////                      Navigator.pushReplacementNamed(context, '/store');
////                    }
////                  }
////                });
////              })
////
////            }
//        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Visibility(
          visible: true,
          child: CircularProgressIndicator(
            backgroundColor: Colors.purple,
            strokeWidth: 5.0,
          ),
        ),
      ),
    );
  }
}
