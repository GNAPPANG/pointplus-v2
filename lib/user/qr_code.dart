import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

final mali = 'Mali';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
  String userID = '';

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid;
    });
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text(
          'คิวอาร์โค้ด',
          style: TextStyle(
            fontFamily: mali,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              data: userID,
              version: QrVersions.auto,
              size: 250,
              gapless: false,
            ),
            SizedBox(height: 20),
            Text(
              'สแกนเพื่อสะสมแต้ม',
              style: TextStyle(
                fontFamily: mali,
                fontSize: 20,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
