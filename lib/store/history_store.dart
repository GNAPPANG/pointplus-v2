import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final mali = 'Mali';
final kalam = 'Kalam';

class HistoryStorePage extends StatefulWidget {
  @override
  _HistoryStorePageState createState() => _HistoryStorePageState();
}

class _HistoryStorePageState extends State<HistoryStorePage> {
  String userID;

  // inputData() async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final FirebaseUser user = await auth.currentUser();
  //   final uid = user.uid.toString();
  //   print(uid);
  //   setState(() {
  //     userID = uid.toString();
  //   });
  // }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ประวัติการทำรายการ',
          style: TextStyle(fontFamily: mali),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.withOpacity(0.1),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('store')
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
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data.documents
                              .map((DocumentSnapshot document) {
                            return listPoint(
                              img: document['userImg'].toString(),
                              date: document['created_at'].toString(),
                              point: document['point'].toString(),
                              id: document['uid'].toString(),
                            );
                          }).toList(),
                          padding: EdgeInsets.only(bottom: 30),
                        )
                      : Center(
                          child: Text('คุณยังไม่มีประวัติการทำรายการ'),
                        );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget listPoint({String img, id, point, date}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 6, bottom: 12),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ID: ${id.toString().substring(0,10)}',
                    style: TextStyle(
                      fontFamily: mali,
                      fontSize: 18.0,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'คุณให้แต้ม $point แต้ม',
                    style: TextStyle(
                      fontFamily: mali,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: mali,
                      fontSize: 14.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
