import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/join/login_page.dart';


final mali = 'Mali';
final kalam = 'Kalam';

class ProfileStorePage extends StatefulWidget {
  @override
  _ProfileStorePageState createState() => _ProfileStorePageState();
}

class _ProfileStorePageState extends State<ProfileStorePage> {
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

  String open = "00:00 น.";
  String close = "00:00 น.";

  DateTime _dateTime = DateTime.now();

  DateTime _setDate = DateTime.now();
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
            stream: Firestore.instance.collection('users').document(userID).snapshots(),
            builder: (contetxt, sn){
              var image = sn.data['proFile'].toString();
              var namestore = sn.data['namestore'].toString();
              var addr = sn.data['address'];
              var contact = sn.data['phone'];
              var email = sn.data['email'];
              var opentime = sn.data['open'];
              var closetime = sn.data['close'];
              return Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    imgPro(img: image),
                    SizedBox(height: 20.0),
                    _form(
                      title: 'ชื่อร้าน',
                      content: namestore,
                    ),
                    SizedBox(height: 20.0),
                    _form(
                      title: 'ที่อยู่',
                      content: addr,
                    ),
                    SizedBox(height: 20.0),
                    _form(
                      title: 'ติดต่อ',
                      content: contact,
                    ),
                    SizedBox(height: 20.0),
                    _form(
                      title: 'อีเมล',
                      content: email,
                    ),
                    SizedBox(height: 20.0),
                    _form(
                      title: 'เวลาเปิด',
                      content: opentime,
                    ),
                    SizedBox(height: 20.0),
                    _form(
                      title: 'เวลาปิด',
                      content: closetime,
                    ),
                    SizedBox(height: 20.0),
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
                    SizedBox(height: 50),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget imgPro({img}) {
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

  Widget showData({img}){
    imgPro(img: img);
  }
}
