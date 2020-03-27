import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:point_plus_v2/join/home.dart';
import 'package:point_plus_v2/services/login.dart';

import 'category_page.dart';
import 'forgot_password.dart';


final kalam = 'Kalam';
final mali = 'Mali';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameCtrl = new TextEditingController();
  TextEditingController _passwordCtrl = new TextEditingController();
  Login login = new Login();
  FirebaseAuth _auth = FirebaseAuth.instance;
  signIn(){
    _auth.signInWithEmailAndPassword(
      email: _usernameCtrl.text.trim().toString(),
      password: _passwordCtrl.text.toString(),
    ).then((user){
      login.singInAuth(context);
      print('ok');
    }).catchError((e){
      print('fuck');
      print(e);
    });
  }



//  Future<DocumentSnapshot> _login() {
//    print(_usernameCtrl.text + _passwordCtrl.text);
//    FirebaseAuth.instance
//        .signInWithEmailAndPassword(
//            email: _usernameCtrl.text, password: _passwordCtrl.text)
//        .then((currentUser) => Firestore.instance
//                .collection("users")
//                .document(currentUser.user.uid)
//                .get()
//                .then(
//              (DocumentSnapshot result) {
//                  Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => HomePage(),
//                    ),
//                  );
//              },
//            ).catchError((err) => print(err)))
//        .catchError((err) => print(err));
//  }

  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {}
              else
                {
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage())))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 0, 235, 140),
                    Color.fromRGBO(100, 0, 235, 190),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 100.0,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  //color: Colors.amberAccent[200],
                  width: 230.0,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          //height: 200.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 10.0,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 24.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                  ),
                                  child: TextField(
                                    controller: _usernameCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'อีเมล',
                                      labelStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: mali,
                                        color: Colors.redAccent[100],
                                      ),
                                      icon: Icon(
                                        Icons.mail,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                  ),
                                  child: TextField(
                                    obscureText: true,
                                    controller: _passwordCtrl,
                                    decoration: InputDecoration(
                                      labelText: 'รหัสผ่าน',
                                      labelStyle: TextStyle(
                                        fontFamily: mali,
                                        fontSize: 12.0,
                                        color: Colors.redAccent[100],
                                      ),
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 32.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              print('forgot pass');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'ลืมรหัสผ่าน?',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: mali,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 40.0,
                            right: 40.0,
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  onPressed: signIn,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(
                                      fontFamily: mali,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  color: Colors.redAccent,
                                  elevation: 3.0,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CategoryPage(),
                                      ),
                                    );
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    'สมัครสมาชิก',
                                    style: TextStyle(
                                      fontFamily: mali,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  color: Colors.redAccent,
                                  elevation: 3.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
