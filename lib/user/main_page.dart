import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';
import 'package:point_plus_v2/user/search_page.dart';

final mali = 'Mali';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBars(
                    h: MediaQuery.of(context).size.height / 7,
                    c: context,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 12),
                    child: Text(
                      'โปรโมชั่นแนะนำ',
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: mali,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    height: MediaQuery.of(context).size.height * 0.40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        promotion(
                          img: 'assets/images/12.jpg',
                        ),
                        promotion(
                          img: 'assets/images/11.jpg',
                        ),
                        promotion(
                          img: 'assets/images/13.jpg',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 12),
                    child: Text(
                      'มาใหม่ !',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: mali,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        add(
                          img: 'assets/images/05.jpg',
                        ),
                        add(
                          img: 'assets/images/02.jpg',
                        ),
                        add(
                          img: 'assets/images/03.jpg',
                        ),
                        add(
                          img: 'assets/images/04.jpg',
                        ),
                        add(
                          img: 'assets/images/01.jpg',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 12),
                    child: Text(
                      'ร้านแนะนำ',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: mali,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        shop(
                          img: 'assets/images/33.png',
                        ),
                        shop(
                          img: 'assets/images/32.jpg',
                        ),
                        shop(
                          img: 'assets/images/34.jpg',
                        ),
                        shop(
                          img: 'assets/images/logocof.jpg',
                        ),
                        shop(
                          img: 'assets/images/31.jpg',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 10, top: 12),
                    child: Text(
                      'ร้าน',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: mali,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    height: MediaQuery.of(context).size.height ,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        store(
                          img: 'assets/images/41.jpg',
                          nameStore: 'Fire tiger',
                        ),
                        store(
                          img: 'assets/images/42.jpg',
                          nameStore: 'ชานม',
                        ),
                        store(
                          img: 'assets/images/43.jpg',
                          nameStore: 'ซูชิ',
                        ),
                        store(
                          img: 'assets/images/44.jpg',
                          nameStore: 'Odtomato',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
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
            iconSize: 60.0,
            color: Colors.white,
            onPressed: () {
              Navigator.of(c).push(_createRoute(screen: ProfileUser()));
            },
          ),
        ],
      ),
    ),
  );
}

Widget store({
  String img,
  String nameStore,
}) {
  return Card(
    elevation: 5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 220,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: Row(
            children: <Widget>[
              Text(
                nameStore,
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget promotion({
  String img,
}) {
  return Card(
    elevation: 5,
    child: Container(
      height: 100,
      width: 400,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Widget add({
  String img,
}) {
  return Card(
    elevation: 5,
    child: Container(
      height: 60,
      width: 180,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}

Widget shop({
  String img,
}) {
  return Container(
    width: 120.0,
    height: 120.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        fit: BoxFit.fill,
        image: AssetImage(img),
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