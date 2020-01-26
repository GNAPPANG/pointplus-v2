

import 'package:flutter/material.dart';

import 'confirm_mail.dart';


final kalam = 'Kalam';
final mali = 'Mali';


class RePasswordPage extends StatefulWidget {
  @override
  _RePasswordPageState createState() => _RePasswordPageState();
}

class _RePasswordPageState extends State<RePasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,  color: Colors.black54),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ConfirmMailPage(),
            ),);
          },
        ),
        title: Text('รีเซ็ตรหัสผ่าน',
          style: TextStyle(
            fontFamily: 'mali' ,
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
              'ตั้งรหัสผ่าน',
              style: TextStyle(
                fontFamily: 'mali' ,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'รหัสผ่าน 6-16 อักขระ',
              style: TextStyle(
                fontFamily: 'mali' ,
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
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: mali,
                                    fontSize: 14.0,
                                  ),
                                  hintText: 'กรุณากรอกรหัสผ่าน',
                                  labelStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: mali,
                                    color: Colors.redAccent[100],
                                  ),
                                  icon: Icon(
                                    Icons.remove_red_eye,
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 70
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                print("dddd");
//                                Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => ChoicePage(),
//                                ),);
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Text(
                                'เสร็จสิ้น',
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
