import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:point_plus_v2/services/login.dart';
import 'category_page.dart';
import 'forgot_password.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


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
  bool load = false;

  signIn() {
    setState(() => load = true);
    _auth
        .signInWithEmailAndPassword(
      email: _usernameCtrl.text.trim().toString(),
      password: _passwordCtrl.text.toString(),
    )
        .then((u) {
      print('loginpage: ${u.user.uid}');
      login.singInAuth(u.user.uid, context);
      setState(() => load = false);
    }).catchError((e) {
      setState(() {
        load = false;
      });
      // input alert pass error
      Alert(
        context: context,
        type: AlertType.error,
        title: "รหัสผ่านไม่ถูกต้อง",
        desc: "กรุณาแก้ไจรหัสผ่านให้ถุกต้อง",
        buttons: [
          DialogButton(
            child: Text(
              "ตกลง",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            color: Color.fromRGBO(0, 179, 134, 1.0),
            radius: BorderRadius.circular(0.0),
          ),
        ],
      ).show();
      print('invalid password');
      print(e);
    });
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
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
            Center(
              child: Visibility(
                  visible: load,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
    );
  }
}
