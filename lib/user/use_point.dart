import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final mali = 'Mali';

class UsePoint extends StatefulWidget {
  static const routeName = '/user-point';

  @override
  _UsePointState createState() => _UsePointState();
}

class _UsePointState extends State<UsePoint> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  String userID = '';
  String storeID = '';
  int currentStorePoints = 0;
  bool isLoading = false;
  String dates = '';
  String times = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    // getCurrentPoint();
  }

  getCurrentUser() async {
    await auth.currentUser().then((user) {
      userID = user.uid.toString();
      print('userID: $userID');
    }).then((value) => getCurrentPoint());
  }

  getCurrentPoint() async {
    var s = firestore
        .collection('users')
        .document(userID)
        .collection('stores')
        .document(storeID);
    s.get().then((doc) {
      setState(() {
        currentStorePoints = doc['store_points'];
      });

      print('currentStorePoints: $currentStorePoints');
    });
  }

  submit(dynamic data) {
    if (currentStorePoints < 10) {
      final snackBar = SnackBar(
        content: Text('แต้มของคุณไม่เพียงพอ'),
      );
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }
    showDate();
    setState(() {
      isLoading = true;
      print('isLoading1: $isLoading');
    });
    print('submit');
    final String storeID = data.data['store_id'];
    final String storeName = data.data['store_name'];
    final String storeImgUrl = data.data['store_photo_url'];
    final int storePoints = currentStorePoints - 10;
    Firestore.instance
        .collection("users")
        .document(userID)
        .collection('stores')
        .document(storeID)
        .setData({
      "store_id": storeID,
      "store_name": storeName,
      "store_photo_url": storeImgUrl,
      "store_points": storePoints,
    }).then((value) {
      Firestore.instance
          .collection("users")
          .document(userID)
          .collection('history')
          .document()
          .setData({
        'created_at': '$dates, $times',
        'type': 'use',
        "point": 10,
        "id": storeID,
        "name": storeName,
        "photo_url": storeImgUrl,
      }).then(
        (value) => getCurrentPoint(),
      );

      final snackBar = SnackBar(
        content: Text('ใช้ 10 แต้มสำเร็จ!!'),
      );
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(snackBar);
      setState(() {
        isLoading = false;
        print('isLoading2: $isLoading');
      });
    });
  }

  showDate() async {
    var d = DateFormat.d().format(DateTime.now());
    var M = DateFormat.M().format(DateTime.now());
    var Y = DateFormat.y().format(DateTime.now());

    var h = DateFormat.Hms().format(DateTime.now());
    var date = '$d/$M/$Y';
    var time = '$h';

    dates = date;
    times = time;
    print(dates);
    print(times);
  }

  @override
  Widget build(BuildContext context) {
    final dynamic data = ModalRoute.of(context).settings.arguments;
    storeID = data.data['store_id'];
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          data.data['store_name'],
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: data.data['store_photo_url'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'แต้มทั้งหมด ' + currentStorePoints.toString() + ' คะแนน',
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  if (currentStorePoints <= 0) {
                    final snackBar = SnackBar(
                      content: Text('แต้มของคุณไม่เพียงพอ!!'),
                    );
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    submit(data);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: !isLoading
                    ? Text(
                        'ใช้ 10 แต้ม',
                        style: TextStyle(
                          fontFamily: mali,
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(5),
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                color: Colors.redAccent,
                elevation: 3.0,
              ),
            ],
          ),
          // Center(
          //   child: Visibility(
          //     visible: isLoading,
          //     child: CircularProgressIndicator(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
