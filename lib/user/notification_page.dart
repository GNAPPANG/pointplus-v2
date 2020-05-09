import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';

final mali = 'Mali';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String userID;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      userID = user.uid.toString();
    });
    print('userID: $userID');
  }

  profile() {
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }

  Widget notiItem({img, nameStore, point, createdAt, type}) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80.0,
        child: RaisedButton(
          onPressed: () {},
          color: Colors.grey[200],
          child: Row(
            children: <Widget>[
              FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: img,
                fit: BoxFit.cover,
                width: 100,
              ),
              SizedBox(
                width: 24.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    nameStore,
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'mali',
                      fontSize: 18.0,
                    ),
                  ),
                  if (type == 'use')
                    Text(
                      'คุณใช้แต้ม $point แต้ม',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'mali',
                        fontSize: 14.0,
                      ),
                    ),
                  if (type == 'transfer')
                    Text(
                      'คุณโอนแต้ม $point แต้ม',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'mali',
                        fontSize: 14.0,
                      ),
                    ),
                  if (type == 'receive')
                    Text(
                      'คุณได้รับแต้ม $point แต้ม',
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: 'mali',
                        fontSize: 14.0,
                      ),
                    ),
                  Text(
                    'เมื่อ $createdAt',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'mali',
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แจ้งเตือน',
          style: TextStyle(fontFamily: mali),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('users')
                .document('$userID')
                .collection('history')
                .orderBy('created_at', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
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
                      ? ListView(
                          shrinkWrap: true,
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return notiItem(
                              createdAt: document['created_at'].toString(),
                              img: document['photo_url'].toString(),
                              nameStore: document['name'].toString(),
                              point: document['point'].toString(),
                              type: document['type'].toString(),
                            );
                          }).toList(),
                          padding: EdgeInsets.only(bottom: 30),
                        )
                      : Center(
                          child: Text('คุณยังไม่มีรายการแจ้งเตือน'),
                        );
              }
            },
          ),
        ],
      ),
    );
  }
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
