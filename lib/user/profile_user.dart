import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:point_plus_v2/join/login_page.dart';

import 'main_page.dart';

final mali = 'Mali';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
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

  String xxx = "วว/ดด/ปปปป";

  DateTime _dateTime = DateTime.now();

  datetime() {
    return CupertinoDatePicker(
      initialDateTime: _dateTime,
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
        setState(() {
          _dateTime = newdate;
        });
      },
      use24hFormat: true,
      maximumDate: new DateTime(2020, 12, 30),
      minimumYear: 1900,
      maximumYear: 2020,
      minuteInterval: 1,
      mode: CupertinoDatePickerMode.date,
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
        backgroundColor: Colors.redAccent,
        title: Text(
          'โปรไฟล์ผู้ใช้',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(userID)
                    .snapshots(),
                builder: (context, sn) {
                  if (!sn.hasData) {
                    return Text('Loading...');
                  }

                  return profile(
                      img: sn.data['proFile'],
                      lastname: sn.data['lastname'],
                      firstname: sn.data['firstname'],
                      email: sn.data['email']);
                }),
          ),
        ),
      ),
    );
  }

  Widget profile({img, firstname, lastname, email}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12),
            Center(
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 5),
                  shape: BoxShape.circle,
                  image: img != null
                      ? DecorationImage(
                          image: NetworkImage(
                            img,
                          ),
                          fit: BoxFit.cover,
                        )
                      : DecorationImage(
                          image: AssetImage('assets/images/person.png'),
                        ),
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(height: 12),
            _form(
              title: 'ชื่อ',
              content: firstname,
            ),
            _form(
              title: 'นามสกุล',
              content: lastname,
            ),
            _form(
              title: 'อีเมล',
              content: email,
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
          ],
        ),
      ),
    );
  }

  Widget _form({
    title,
    content,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
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
