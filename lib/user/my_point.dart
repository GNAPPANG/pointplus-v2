import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/point.dart';
import 'package:point_plus_v2/user/profile_user.dart';
import 'package:point_plus_v2/user/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final mali = 'Mali';

class MyPoint extends StatefulWidget {
  @override
  _MyPointState createState() => _MyPointState();
}

class _MyPointState extends State<MyPoint> {
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  String userID = '';

  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  profile() {
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }

  @override
  initState() {
    super.initState();
    inputData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แต้มของฉัน',
          style: TextStyle(fontFamily: mali),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: ListPage(userID: userID),
    );
  }
}

class ListPage extends StatefulWidget {
  ListPage({this.userID});

  final String userID;
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPoints() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection('users')
        .document(widget.userID)
        .collection('stores')
        .getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(widget.userID)
          .collection('stores')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                ? ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Point(snapshot.data.documents[index]),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: double.infinity,
                                  height: 100,
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/placeholder.png',
                                    image: snapshot.data.documents[index]
                                        .data['store_photo_url'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data.documents[index]
                                          .data['store_name'],
                                      style: TextStyle(
                                        fontFamily: mali,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      snapshot.data.documents[index]
                                              .data['store_points']
                                              .toString() +
                                          ' แต้ม',
                                      style: TextStyle(
                                        fontFamily: mali,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('คุณยังไม่มีแต้ม'),
                  );
        }
      },
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
