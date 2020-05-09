import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:rflutter_alert/rflutter_alert.dart';

final mali = 'Mali';
final kalam = 'Kalam';

class ScanStorePage extends StatefulWidget {
  @override
  _ScanStorePageState createState() => _ScanStorePageState();
}

class _ScanStorePageState extends State<ScanStorePage> {
  Uint8List bytes = Uint8List(0);
  TextEditingController pointCtrl = new TextEditingController();
  String userID = '';
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  String userImgUrl = '';
  String dates = '';
  String times = '';
  String allpoint = '';
  String storeID = '';
  String storeName = '';
  String storeImgUrl = '';
  int currentStorePoints = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // storeData();
    _scan();
    getCurrentUser();
  }

  getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print('uid: $uid');

    var s = firestore.collection('store').document(uid);
    s.get().then((doc) {
      storeID = doc['uid'];
      storeName = doc['namestore'];
      storeImgUrl = doc['proFile'];
    });
  }

  getUrl() async {
    var s = firestore.collection('users').document(userID);
    s.get().then((doc) {
      print('url: ' + doc['proFile']);
      userImgUrl = doc['proFile'].toString();
      debugPrint('url2: $userImgUrl');
    });
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

  submitPoint() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });

    int point = int.parse(pointCtrl.text);
    // String p = pointCtrl.text.trim().toString();

    // if (_formKey.currentState.validate()) {
    showDate();

    Firestore.instance
        .collection("users")
        .document(userID)
        .collection('stores')
        .document(storeID)
        .setData({
      "store_id": storeID,
      "store_name": storeName,
      "store_photo_url": storeImgUrl,
      "store_points": currentStorePoints + point,
    }).then((result) {
      Firestore.instance
          .collection('store')
          .document(storeID)
          .collection('history')
          .document()
          .setData({
        'created_at': '$dates, $times',
        'point': point,
        'uid': userID,
        'userImg': userImgUrl,
      }).then((value) {
        Firestore.instance
            .collection("users")
            .document(userID)
            .collection('history')
            .document()
            .setData({
          'created_at': '$dates, $times',
          'type': 'receive',
          "point": point,
          "id": storeID,
          "name": storeName,
          "photo_url": storeImgUrl,
        }).then((value) {
          pointCtrl.text = '';
          setState(() {
            isLoading = false;
          });
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
        });
      }).catchError((err) {
        setState(() {
          isLoading = false;
        });
        print('error: $err');
      });
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });
      print('error: $err');
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              _scan();
            },
            icon: Icon(
              Icons.center_focus_weak,
              size: 38,
              color: Colors.white,
            ),
          )
        ],
        title: Text(
          'สแกนคิวอาร์โค้ด',
          style: TextStyle(
            fontFamily: mali,
          ),
        ),
        backgroundColor: Colors.redAccent,
        leading: Container(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: userID != ''
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('User ID: $userID'),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'จำนวนคะแแนน',
                              errorStyle: TextStyle(fontFamily: mali),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'จำนวนแต้มห้ามว่าง';
                              }
                              return null;
                            },
                            controller: pointCtrl,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        onPressed: submitPoint,
                        child: !isLoading
                            ? Text('โอนคะแนน')
                            : Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ],
                  ),
                ],
              )
            : Center(
                child: Text('กรุณาสแกน QR CODE'),
              ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() {
      userID = barcode.toString();
    });
    getUrl();
    getCurrentPoint();
  }
}
