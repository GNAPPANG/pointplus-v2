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
  String url = '';
  String dates = '';
  String times = '';
  String allpoint = '';
  String storeID = '';
  String storeName = '';
  String storePhotoUrl = '';
  int currentStorePoints = 0;

  storeData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    var s = await firestore.collection('users').document(uid);
    s.get().then((doc) {
      setState(() {
        storeID = doc['uid'];
        storeName = doc['namestore'];
        storePhotoUrl = doc['proFile'];
      });
    });
  }

  getUrl() async {
    var s = await firestore.collection('users').document(userID);
    s.get().then((doc) {
      print('url: ' + doc['proFile']);
      setState(() {
        url = doc['proFile'].toString();
        debugPrint('url2: $url');
      });
    });
  }

  getCurrentPoint() async {
    var s = await firestore.collection('users').document(userID).collection('stores').document(storeID);
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
    setState(() {
      dates = date;
      times = time;
    });
    print(dates);
    print(times);

  }

  submitPoint() async {
    String p = pointCtrl.text.trim().toString();
    if (_formKey.currentState.validate()) {
      showDate();
      Firestore.instance
          .collection("users")
          .document(userID)
          .collection('stores')
          .document(storeID)
          .setData({
        "store_id": storeID,
        "store_name": storeName,
        "store_photo_url": storePhotoUrl,
        "store_points": currentStorePoints + 1,
      }).then((result) {
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
      }).catchError((err) {
        print('error: $err');
      });
    }
  }

  @override
  initState() {
    storeData();
    super.initState();
    _scan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: showDate,
            child: Text('showdt'),
          ),
          Text(userID),
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
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
          RaisedButton(
            onPressed: submitPoint,
            child: Text('ตกลง'),
          ),

        ],
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
