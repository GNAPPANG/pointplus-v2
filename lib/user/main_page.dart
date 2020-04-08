import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';

final mali = 'Mali';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  profile(){
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(child: Text('หน้าแรก', style: TextStyle(fontFamily: mali), textAlign: TextAlign.center,)),
            GestureDetector(
              onTap: profile,
              child: Icon(
                Icons.account_circle,
                size: 45,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

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
      ),
    );
  }
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