import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';
import 'package:qrscan/qrscan.dart' as scanner;

final mali = 'Mali';

class TransferPoint extends StatefulWidget {
  @override
  _TransferPointState createState() => _TransferPointState();
}

class _TransferPointState extends State<TransferPoint> {
  String url = '';
  String userID = '';
  Firestore firestore = Firestore.instance;
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
  profile(){
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(child: Text('โอนแต้ม', style: TextStyle(fontFamily: mali), textAlign: TextAlign.center,)),
            GestureDetector(
              onTap: profile,
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
                          Container(
                              width: 180.0,
                              height: 180.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/images/upload.png'),
                                  ))),
                          SizedBox(
                            height: 8.0,
                          ),

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
                                  child: TextField(
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

//                                  child: Row(
//                                    children: <Widget>[
//                                      Text(
//                                        'จำนวนแต้ม',
//                                        style: TextStyle(
//                                          color: Colors.black54,
//                                          fontFamily: mali,
//                                          fontSize: 12.0,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    'ตกลง',
                                    style: TextStyle(
                                      fontFamily: mali,
                                      fontSize: 14.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
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
      userID = barcode.toString();
    });
    getUrl();
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



