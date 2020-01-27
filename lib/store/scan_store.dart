import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

final mali = 'Mali';
final kalam = 'Kalam';

class ScanStorePage extends StatefulWidget {
  @override
  _ScanStorePageState createState() => _ScanStorePageState();
}

class _ScanStorePageState extends State<ScanStorePage> {

  String barcode = '';
  Uint8List bytes = Uint8List(200);

  @override
  initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    appBars(
                      h: MediaQuery
                          .of(context)
                          .size
                          .height / 7,
                      c: context,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                  'RESULT  $barcode'
              ),
            ),
            RaisedButton(
                onPressed: _scan,
                child: Text(
                    "Scan"
                ),
            ),

          ],
        ),
      ),
    );

  }

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
  }

//  Future _scanPhoto() async {
//    String barcode = await scanner.scanPhoto();
//    setState(() => this.barcode = barcode);
//  }

  Future _generateBarCode() async {
    Uint8List result = await scanner.generateBarCode('https://github.com/leyan95/qrcode_scanner');
    this.setState(() => this.bytes = result);
  }
}




//----------------------------------


Widget appBars({h, c}) {
  return Container(
    height: h,
    color: Colors.redAccent,
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'สแกนคิวอาร์โค้ด',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: 'mali',
            ),
          ),
          SizedBox(
              width: 20
          ),
        ],
      ),
    ),
  );
}