import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  TextEditingController _inputController;
  TextEditingController _outputController;
  TextEditingController pointCtrl = new TextEditingController();
  String userID = '';
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  submitPoint()async{
    String p = pointCtrl.text.trim().toString();
    if(_formKey.currentState.validate()){
      final FirebaseUser user = await auth.currentUser();
      Firestore.instance
            .collection("users")
            .document(userID)
            .collection('point')
            .add({
        "point": p,
        "uid": userID,
        "create_at": DateTime.now(),
      })
          .then((result){
            print('success');
            Alert(
              context: context,
              type: AlertType.success,
              title: "ทำรายการสำเร็จ",
              buttons: [

                DialogButton(
                  child: Text(
                    "ตกลง",
                    style: TextStyle(fontFamily: mali, color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () => Navigator.pop(context),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                )
              ],
            ).show();
      })
          .catchError((err){
         print('error: $err');
      });
    }


  }

  @override
  initState() {
    super.initState();
    _scan();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
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
          Text(userID),
          Form(
            key: _formKey,
            child: TextFormField(
              decoration: InputDecoration(
                errorStyle: TextStyle(fontFamily: mali),
              ),
              validator: (value){
                if(value.isEmpty){
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
//    this._outputController.text = barcode;
  setState(() {
    userID = barcode.toString();
  });
  }
}

