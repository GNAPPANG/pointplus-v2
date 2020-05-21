import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:point_plus_v2/user/profile_user.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rflutter_alert/rflutter_alert.dart';

final mali = 'Mali';

class TransferPoint extends StatefulWidget {
  TransferPoint({this.storeID});

  final String storeID;
  @override
  _TransferPointState createState() => _TransferPointState();
}

class _TransferPointState extends State<TransferPoint> {
  String userID = '';
  String userName = '';
  String userPhotoUrl = '';
  String friendID = '';
  String friendName = '';
  String friendPhotoUrl = '';
  String storeName = '';
  String storePhotoUrl = '';
  int currentStorePointsOfFriend = 0;
  int currentStorePointsOfUser = 0;
  TextEditingController pointController = new TextEditingController();
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String dates = '';
  String times = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    inputData();
    getUserCurrentStorePoints();
    getStoreDetail();
  }
  //ดึงข้อมูลตัวเรา
  inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    setState(() {
      userID = uid.toString();
    });

    await firestore.collection('users').document(uid).get().then((doc) {
      userName = doc['firstname'] + ' ' + doc['lastname'];
      userPhotoUrl = doc['proFile'];
    });
  }

  getUserCurrentStorePoints() async {
    await auth.currentUser().then((user) {
      firestore
          .collection('users')
          .document(user.uid)
          .collection('stores')
          .document(widget.storeID)
          .get()
          .then((doc) {
        setState(() {
          currentStorePointsOfUser = doc['store_points'];
        });
      });
    });
  }

  profile() {
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }

  //ดึงขอมูลของร้านค้า
  getStoreDetail() async {
    var s = await firestore.collection('store').document(widget.storeID);
    s.get().then((doc) {
      setState(() {
        storeName = doc['namestore'];
        storePhotoUrl = doc['proFile'];
      });
    });
  }

  getFriendInfo() async {
    var s = await firestore.collection('users').document(friendID);
    s.get().then((doc) {
      setState(() {
        friendName = doc['firstname'] + ' ' + doc['lastname'];
        friendPhotoUrl = doc['proFile'];
      });
    });
  }

  getFriendCurrentStorePoints() async {
    var s = await firestore
        .collection('users')
        .document(friendID)
        .collection('stores')
        .document(widget.storeID);
    s.get().then((doc) {
      setState(() {
        currentStorePointsOfFriend = doc['store_points'];
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

  submitTransferPoint() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    if (friendID.isEmpty) {
      final snackBar = SnackBar(
        content: Text('กรุณาเลือกผู้รับ'),
      );
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }
    if (userID == friendID) {
      final snackBar = SnackBar(
        content: Text('ไม่สามารถโอนให้ตัวเองได้'),
      );
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    setState(() {
      isLoading = true;
    });
    showDate();
    int point = int.parse(pointController.text) ?? 0;

    Firestore.instance
        .collection("users")
        .document(friendID)
        .collection('stores')
        .document(widget.storeID)
        .get()
        .then((doc) {
      if (doc.data == null) {
        Firestore.instance
            .collection("users")
            .document(friendID)
            .collection('stores')
            .document(widget.storeID)
            .setData({
          "store_id": widget.storeID,
          "store_name": storeName,
          "store_photo_url": storePhotoUrl,
          "store_points": currentStorePointsOfFriend + point,
        });
      } else {
        Firestore.instance
            .collection("users")
            .document(friendID)
            .collection('stores')
            .document(widget.storeID)
            .updateData({
          "store_points": currentStorePointsOfFriend + point,
        });
      }
    }).then((value) {
      Firestore.instance
          .collection("users")
          .document(userID)
          .collection('stores')
          .document(widget.storeID)
          .updateData({
        "store_points": currentStorePointsOfUser - point,
      }).then((value) {
        Firestore.instance
            .collection("users")
            .document(userID)
            .collection('history')
            .document()
            .setData({
          'created_at': '$dates, $times',
          "point": point,
          "id": friendID,
          "name": friendName,
          "photo_url": friendPhotoUrl,
          "type": 'transfer',
        }).then((value) {
          Firestore.instance
              .collection("users")
              .document(friendID)
              .collection('history')
              .document()
              .setData({
            'created_at': '$dates, $times',
            "point": point,
            "id": userID,
            "name": userName,
            "photo_url": userPhotoUrl,
            "type": 'receive',
          }).then((value) {
            setState(() {
              isLoading = false;
            });
            pointController.text = '';
            getUserCurrentStorePoints();
            getFriendCurrentStorePoints();
            print('success');
            Alert(
              context: context,
              type: AlertType.success,
              title: "ทำรายการสำเร็จ",
              buttons: [
                DialogButton(
                  child: Text(
                    "ตกลง",
                    style: TextStyle(
                        fontFamily: mali, color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                )
              ],
            ).show();
          }).catchError((error) {
            setState(() {
              isLoading = false;
            });
          });
        }).catchError((error) {
          setState(() {
            isLoading = false;
          });
        });
      }).catchError((erorr) {
        setState(() {
          isLoading = false;
        });
      });
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
    });
  }

  deductPoint() async {
    int p = int.parse(pointController.text) ?? 0;
    Firestore.instance
        .collection("users")
        .document(userID)
        .collection('stores')
        .document(widget.storeID)
        .setData({
      "store_id": widget.storeID,
      "store_name": storeName,
      "store_photo_url": storePhotoUrl,
      "store_points": currentStorePointsOfUser - p,
    }).then((result) {
      print('success');
    }).catchError((err) {
      print('error: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'โอนแต้ม',
              style: TextStyle(fontFamily: mali),
              textAlign: TextAlign.center,
            )),
            GestureDetector(
              onTap: _scan,
              child: Icon(
                Icons.center_focus_weak,
                size: 38,
                color: Colors.white,
              ),
            ),
          ],
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
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 16.0,
                          ),
                          friendPhotoUrl == ''
                              ? Container(
                                  width: 180.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/images/upload.png')),
                                  ),
                                )
                              : Container(
                                  width: 180.0,
                                  height: 180.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/placeholder.png',
                                    image: friendPhotoUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(friendName),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  color: Colors.grey[200],
                                  onPressed: () {},
                                  child: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'จำนวนแต้มห้ามว่าง';
                                        }
                                        return null;
                                      },
                                      controller: pointController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 20.0),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: mali,
                                          fontSize: 14.0,
                                        ),
                                        hintText: "จำนวนแต้ม",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    submitTransferPoint();
                                    // deductPoint();
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: !isLoading
                                      ? Text(
                                          'ตกลง',
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
                                    vertical: 2.0,
                                  ),
                                  color: Colors.redAccent,
                                  elevation: 3.0,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60.0,
          ),
        ],
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() {
      friendID = barcode.toString();
    });
    getFriendInfo();
    getFriendCurrentStorePoints();
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
