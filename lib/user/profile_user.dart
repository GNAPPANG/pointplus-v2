import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/join/login_page.dart';

import 'main_page.dart';

final mali = 'Mali';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  File _image;
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

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _image = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_image != null) {
      return Image.file(_image);
    } else {
      return Text('Take an image to start', style: TextStyle(fontSize: 18.0));
    }
  }



  void _showActionSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text("Camera"),
                  onTap: () async {
                    captureImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text("Gallery"),
                  onTap: () async {
                    captureImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  String xxx = "วว/ดด/ปปปป";

  int _gValue;

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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
        ),
        title: Text(
          'โปรไฟล์ผู้ใช้',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream:
                Firestore.instance.collection('users').document(userID).snapshots(),
            builder: (context, sn){
              var img = sn.data['proFile'].toString();
              var fname = sn.data['firstname'].toString();
              var lname = sn.data['lastname'].toString();
              var email = sn.data['email'].toString();
              return profile(
                img: img,
                firstname: fname,
                lastname: lname,
                email: email,
              );
            }),
        ),
      ),
    );
  }
  Widget profile({
    img,
    firstname,
    lastname,
    email
  }) {
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
                  image: DecorationImage(
                    image: NetworkImage(
                      img,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(firstname,style: TextStyle(fontFamily: _kanit, fontSize: 22.0),),
//                SizedBox(width: 20.0),
//                Text(lastname,style: TextStyle(fontFamily: _kanit, fontSize: 22.0),),
//              ],
//            ),
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
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
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
          Text(content, style: TextStyle(
            fontFamily: mali,
            fontSize: 18.0,
            color: Colors.black54,
          ),),
          Divider(
            thickness: 2,
            color: Colors.black45,
          ),
        ],
      ),
    );
  }
}



