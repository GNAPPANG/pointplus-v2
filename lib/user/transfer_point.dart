import 'dart:math';

import 'package:flutter/material.dart';



final mali = 'Mali';

class TransferPoint extends StatefulWidget {
  @override
  _TransferPointState createState() => _TransferPointState();
}

class _TransferPointState extends State<TransferPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 42.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey[200]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black54),
                    hintText: "ค้นหา ID",
                  ),
                ),
              ),
            ),
            SizedBox(width: 20,),

          ],
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
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[

                          SizedBox(
                            height: 16.0,
                          ),
                          Container(
                              width: 180.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/images/pup.jpg'),
                                  )
                              )),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'ID : U45386',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 18.0,
                              fontFamily: 'mali',
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  color: Colors.grey[200],
                                  onPressed: () {},
                                  child: TextField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 20.0),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                        fontFamily: mali,
                                        fontSize: 14.0,
                                      ),
                                      hintText: "จำนวนแต้ม",
                                    ),
                                  ),

//                                  child: Row(
//                                    children: <Widget>[
//                                      Text(
//                                        'จำนวนแต้ม',
//                                        style: TextStyle(
//                                          color: Colors.black54,
//                                          fontFamily: mali,
//                                          fontSize: 12.0,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    'ตกลง',
                                    style: TextStyle(
                                      fontFamily: mali,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.0,
                                  ),
                                  color: Colors.redAccent,
                                  elevation: 3.0,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'แต้มคงเหลือของฉัน',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: 22.0,
                              fontFamily: 'mali',
                            ),
                          ),
                          Image.asset(
                            'assets/images/star.png',
                            width: 160.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60.0,
          ),
        ],
      ),
    );
  }
}






