import 'package:flutter/material.dart';
import 'package:point_plus_v2/join/re_password.dart';

import 'choice_page.dart';
import 'forgot_password.dart';

final kalam = 'Kalam';
final mali = 'Mali';

class ConfirmMailPage extends StatefulWidget {
  @override
  _ConfirmMailPageState createState() => _ConfirmMailPageState();
}

class _ConfirmMailPageState extends State<ConfirmMailPage> {
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
                builder: (context) => ForgotPasswordPage(),
              ),
            );
          },
        ),
        title: Text(
          'รีเซ็ตรหัสผ่าน',
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
              height: 24.0,
            ),
            Text(
              'ใส่รหัสยืนยัน 4 ตัวที่ส่งไปยังอีเมลของคุณ ',
              style: TextStyle(
                fontFamily: 'mali',
                fontSize: 16,
                color: Colors.black54,
              ),
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
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: '',
                                  labelStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: mali,
                                    color: Colors.redAccent[100],
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
                      padding: EdgeInsets.only(
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RePasswordPage(),
                                  ),
                                );
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'ยินยัน',
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
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                print("ppppp");
//                                Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => RePasswordPage(),
//                                ),);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'รับรหัสผ่านใหม่',
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
