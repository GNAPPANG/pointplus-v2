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
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) => {
          if (user == null)
            {Navigator.pushReplacementNamed(context, '/login')}
          else
            {
              FirebaseAuth.instance.currentUser().then((user) {
                Firestore.instance
                    .collection('accounts')
                    .where('uid', isEqualTo: user.uid)
                    .getDocuments()
                    .then((doc) {
                  if (doc.documents[0].exists) {
                    if (doc.documents[0].data['role'] == 'user') {
                      Navigator.pushReplacementNamed(context, '/user');
                    }else if (doc.documents[0].data['status'] == 'a' && data['role'] == 'store'){
                      Navigator.pushReplacementNamed(context,'/store');
                    } else {
                      final snackBar = SnackBar(
                        content: Text('ไม่สามารถเข้าสู้ระบบได้'),
                      );
                      _scaffoldKey.currentState.showSnackBar(snackBar);
                    }
                  }
                });
              })

            }
        });

    super.initState();
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
