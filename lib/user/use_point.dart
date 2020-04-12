import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/point.dart';

final mali = 'Mali';

class UsePoint extends StatefulWidget {
  @override
  _UsePointState createState() => _UsePointState();
}

class _UsePointState extends State<UsePoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'ชื่อร้านค้า',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Image.asset(
                        'assets/images/04.jpg',
                        width: 100.0,
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
//                            Navigator.push(context, MaterialPageRoute(
//                              builder: (context) => Point(),
//                            ),);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'ใช้ 10 แต้ม',
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
                      SizedBox(
                        width: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
