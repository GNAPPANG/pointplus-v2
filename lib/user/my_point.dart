import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/point.dart';
import 'package:point_plus_v2/user/profile_user.dart';
import 'package:point_plus_v2/user/search_page.dart';

final mali = 'Mali';

class MyPoint extends StatefulWidget {
  @override
  _MyPointState createState() => _MyPointState();
}

class _MyPointState extends State<MyPoint> {
  profile(){
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text('แต้มของฉัน',
          style: TextStyle(fontFamily: mali),
        ),
        centerTitle: true,

        backgroundColor: Colors.redAccent,
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
                        width: 20.0,
                      ),
                      Image.asset(
                        'assets/images/04.jpg',
                        width: 100.0,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Point(),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Coffee Time',
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
                      Image.asset(
                        'assets/images/star.png',
                        width: 100.0,
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

Widget appBars({h, c}) {
  return Container(
    height: h,
    color: Colors.redAccent,
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              color: Colors.grey[200],
              onPressed: () {
                print('tap to search page');
                Navigator.push(
                    c, MaterialPageRoute(builder: (c) => SearchPage()));
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    'ค้นหา',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: mali,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 50.0,
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  c, MaterialPageRoute(builder: (c) => ProfileUser()));
            },
          ),
        ],
      ),
    ),
  );
}

Route _createRoute({screen}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}