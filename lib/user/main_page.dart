import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                    height: 20,
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
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/12.jpg'),
                              height: 100.0,
                              width: 400.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/11.jpg'),
                              height: 100.0,
                              width: 400.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/13.jpg'),
                              height: 100.0,
                              width: 400.0,
                              fit: BoxFit.cover,
                            ),
                          ),
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
                      horizontal: 16.0,
                    ),
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/01.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/02.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/03.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/04.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image(
                              image: AssetImage('assets/images/05.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
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
                        Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      AssetImage('assets/images/logocof.jpg'),
                                ))),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/31.jpg'),
                                ))),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/32.jpg'),
                                ))),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/34.jpg'),
                                ))),
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage('assets/images/33.png'),
                                ))),
                        SizedBox(
                          width: 16,
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
                    height: MediaQuery.of(context).size.height * 0.28,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
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
                    height: 50.0,
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
              Navigator.push(
                  c, MaterialPageRoute(builder: (c) => ProfileUser()));
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
      children: <Widget>[
        Container(
          height: 150,
          width: 200,
          decoration: BoxDecoration(

            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(nameStore),
      ],
    ),
  );
}
