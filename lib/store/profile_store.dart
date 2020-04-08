import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:point_plus_v2/join/login_page.dart';

final mali = 'Mali';
final kalam = 'Kalam';

class ProfileStorePage extends StatefulWidget {
  @override
  _ProfileStorePageState createState() => _ProfileStorePageState();
}

class _ProfileStorePageState extends State<ProfileStorePage> {
  String userID = '';

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  String open = "00:00 น.";
  String close = "00:00 น.";

  Duration initialtimer = new Duration();
  int selectitem = 1;

  Widget time() {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
        });
      },
    );
  }

  _signout() {
    FirebaseAuth.instance
        .signOut()
        .then((result) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())))
        .catchError((err) => print(err));
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
        leading: Container(),
        title: Text(
          'โปรไฟล์ร้าน',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('users').document(userID)
                .snapshots(),
            builder: (context, sn) {
              if (!sn.hasData) {
                return Visibility(
                  visible: true,
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  store(
                    img: sn.data['proFile'],
                  ),
                  SizedBox(height: 20),
                  _form(
                    content: sn.data['namestore'],
                    title: 'ชื่อร้าน',
                  ),
                  _form(
                    content: sn.data['address'],
                    title: 'ที่อยู่',
                  ),
                  _form(
                    content: sn.data['phone'],
                    title: 'ติดต่อ',
                  ),
                  _form(
                    content: sn.data['email'],
                    title: 'อีเมล',
                  ),
                  _form(
                    content: sn.data['open'],
                    title: 'เวลาเปิด',
                  ),
                  _form(
                    content: sn.data['close'],
                    title: 'เวลาปิด',
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'ออกจากระบบ',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: mali,
                              fontSize: 18.0,
                            ),
                          ),
                          onPressed: _signout,
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20.0,
                              // has the effect of softening the shadow
                              spreadRadius: 4.0,
                              // has the effect of extending the shadow
                              offset: Offset(
                                8.0, // horizontal, move right 10
                                8.0, // vertical, move down 10
                              ),
                            )
                          ],
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget store({img, content, title}) {
    return Column(
      children: <Widget>[
        imgPro(img),
      ],
    );
  }

  Widget imgPro(img) {
    return Container(
      width: 180.0,
      height: 180.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 5),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _form({
    title,
    content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: mali,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontFamily: mali,
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
          Divider(
            thickness: 2,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}
