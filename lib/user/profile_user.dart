import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/join/login_page.dart';
import 'package:point_plus_v2/join/plan.dart';
import 'package:point_plus_v2/user/pro/mail_upro.dart';
import 'package:point_plus_v2/user/pro/name_upro.dart';
import 'package:point_plus_v2/user/pro/password_upro.dart';
import 'package:point_plus_v2/user/pro/phone_upro.dart';
import 'package:point_plus_v2/user/pro/surname_upro.dart';
import 'package:point_plus_v2/user/pro/username_upro.dart';

import 'main_page.dart';

final mali = 'Mali';

class ProfileUser extends StatefulWidget {
  @override
  _ProfileUserState createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  File _image;

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8.0,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: new SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (_image != null)
                                      ? Image.file(
                                          _image,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.asset('assets/images/upload.png'),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 130, top: 90),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  _showActionSheet();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'ID : U23453',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 18.0,
                          fontFamily: 'mali',
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("aaaaa");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NameUproPage(),
                                ),
                              );
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//                            Icon(
//                              Icons.supervised_user_circle,
//                              color: Colors.black54,
//                              size: 50,
//                            ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'ชื่อ',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      'มาริน่า',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("bbbbb");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SurnameUproPage(),
                                ),
                              );
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//                            Icon(
//                              Icons.supervised_user_circle,
//                              color: Colors.black54,
//                              size: 50,
//                            ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'นามสกุล',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      'เชอร์เบ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("bbbbb");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UsernameUproPage(),
                                ),
                              );
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//                            Icon(
//                              Icons.supervised_user_circle,
//                              color: Colors.black54,
//                              size: 50,
//                            ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'ชื่อผู้ใช้',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      'Mareena',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext builder) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 20,
                                            top: 20,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              print('donexxx');
                                              // ดึงวันที่ใส่ใน textformfield
                                              print('${_dateTime.day}');
                                              setState(() {
                                                xxx = _dateTime.day.toString() +
                                                    '/' +
                                                    _dateTime.month.toString() +
                                                    '/' +
                                                    _dateTime.year.toString();
                                              });

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'เสร็จสิ้น',
                                              style: TextStyle(
                                                fontFamily: mali,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .copyWith()
                                                    .size
                                                    .height /
                                                3,
                                            child: datetime(),
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'วันเกิด',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      xxx,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("ccccc");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhoneUproPage(),
                                ),
                              );
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'เบอร์โทรศัพท์',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      '0899376458',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("ccccc");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MailUproPage(),
                                ),
                              );
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'อีเมล',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      'mareena21@gmail.com',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
                              print("ccccc");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PasswordUproPage(),
                                ),
                              );
                            },
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//                            Icon(
//                              Icons.supervised_user_circle,
//                              color: Colors.black54,
//                              size: 50,
//                            ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'รหัสผ่าน',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Text(
                                      'เปลี่ยนรหัสผ่าน',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'mali',
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black54,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      InkWell(
                        onTap: () {
                          print("ssss");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlanPage(),
                            ),
                          );
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.library_books,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'ข้อตกลงและเงื่อนไข & นโยบาย',
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 12.0,
                                  fontFamily: 'mali',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: RaisedButton(
                                onPressed: () {
                                  print('${_gValue}');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'บันทึก',
                                  style: TextStyle(
                                    fontFamily: mali,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                color: Colors.redAccent,
                                elevation: 3.0,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: RaisedButton(
                                onPressed: () {
                                  FirebaseAuth.instance
                                      .signOut()
                                      .then((result) =>
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())))
                                      .catchError((err) => print(err));
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'ออกจากระบบ',
                                  style: TextStyle(
                                    fontFamily: mali,
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                ),
                                color: Colors.redAccent,
                                elevation: 3.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
