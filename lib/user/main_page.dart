import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';
import 'package:point_plus_v2/user/store_item.dart';

final mali = 'Mali';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Firestore firestore = Firestore.instance;

  profile() {
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'หน้าแรก',
          style: TextStyle(fontFamily: mali),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Stack(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'ร้านอาหารทั้งหมด',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: mali,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('store')
                            // .document('$userID')
                            // .collection('history')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                child: Visibility(
                                  visible: true,
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            default:
                              return snapshot.data.documents.length > 0
                                  ? Column(
                                      children: snapshot.data.documents.map(
                                        (DocumentSnapshot document) {
                                          return StoreItem(document);
                                        },
                                      ).toList(),
                                    )
                                  : Center(
                                      child:
                                          Text('ยังไม่มีร้านค้าเปิดให้บริการ'),
                                    );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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

Widget storelist() {
  return ListView(
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
  );
}
