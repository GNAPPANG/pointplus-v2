import 'package:flutter/material.dart';
import 'package:point_plus_v2/store/restore.dart';
import 'package:point_plus_v2/user/reuser.dart';

import 'login_page.dart';


final mali = 'Mali';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,  color: Colors.white),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),);
          },
        ),
        title: Text('ประเภทผู้ใช้งาน',
          style: TextStyle(
            fontFamily: 'mali' ,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[

          Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    'กรุณาเลือกประเภทผู้ใช้',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 25.0,
                      fontFamily: 'mali',
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                        horizontal: 30.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 52.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) => RestorePage(),
                        ),);
                        } ,
                        color: Colors.redAccent[200],
                        elevation: 10.0,
                        child: Text(
                          'ผู้ประกอบการร้านค้า',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'mali' ,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 52.0,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ReuserPage(),
                          ),);
                        } ,
                        color: Colors.redAccent[200],
                        elevation: 10.0,
                        child: Text(
                          'ผู้ใช้ทั่วไป',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'mali' ,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
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

