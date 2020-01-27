import 'package:flutter/material.dart';
import 'package:point_plus_v2/store/homestore.dart';
import 'category_page.dart';
import 'forgot_password.dart';
import 'home.dart';

final kalam = 'Kalam';
final mali = 'Mali';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameCtrl = new TextEditingController();
  TextEditingController _passwordCtrl = new TextEditingController();

  userLogin() {
    String user = 'user';
    String userpass = '1234';

    String store = 'store';
    String storepass = '1234';

    String status_user; // status_user == 1 => user

    String username = _usernameCtrl.text;
    String password = _passwordCtrl.text;

    print(username + password);

    if (username == 'user') {
      status_user = '1';
    } else {
      status_user = '2';
    }

    print(status_user);

    if (username == 'user' && password == '1234') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (username == 'store' && password == '1234') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomestorePage()));
    } else {
      return AlertDialog(
        title: Text('warning'),
        content: Text('username or password invalid'),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
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
                                  onPressed: () {
                                    userLogin();
                                  },
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
