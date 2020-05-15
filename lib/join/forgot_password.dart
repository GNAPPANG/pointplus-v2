import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

final kalam = 'Kalam';
final mali = 'Mali';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();

}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailCtrl = TextEditingController();


  resetPassword(){
    if (_formkey.currentState.validate()) {
      String emails = emailCtrl.text.trim().toString();
      print(emails);
      _auth.sendPasswordResetEmail(email: emails);
    }
    print('success');
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) && value.length < 5) {
      return 'อีเมลไม่ถูกต้อง';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black54),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
            );
          },
        ),
        title: Text(
          'ลืมรหัสผ่าน',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
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
                              child: Form(
                                key: _formkey,
                                child: TextFormField(
                                  controller: emailCtrl,
                                  validator: emailValidator,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontFamily: mali,
                                      fontSize: 14.0,
                                    ),
                                    hintText: 'กรุณากรอกอีเมล',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: resetPassword,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'รีเซ็ตรหัสผ่าน',
                                style: TextStyle(
                                  fontFamily: mali,
                                  fontSize: 12.0,
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
      ),
    );


  }
}
