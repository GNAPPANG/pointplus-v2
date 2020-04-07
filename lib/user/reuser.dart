import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/join/category_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:point_plus_v2/services/new_update_info.dart';
import 'package:point_plus_v2/user/main_page.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

final mali = 'Mali';

class ReuserPage extends StatefulWidget {
  @override
  _ReuserPageState createState() => _ReuserPageState();
}

class _ReuserPageState extends State<ReuserPage> {
  String _age = 'Birth Day';
  final _formKey = GlobalKey<FormState>();
  File _image;
  NewUpdateInfo updateInfo = new NewUpdateInfo();

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

  FirebaseAuth _auth = FirebaseAuth.instance;

//  void _showActionSheet() {
//    showModalBottomSheet(builder: (BuildContext context) {
//      return SafeArea(
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            new ListTile(
//              leading: new Icon(Icons.photo_camera),
//              title: new Text("Camera"),
//              onTap: () async {
//                captureImage(ImageSource.camera);
//                Navigator.of(context).pop();
//              },
//            ),
//            new ListTile(
//              leading: new Icon(Icons.photo_library),
//              title: new Text("Gallery"),
//              onTap: () async {
//                captureImage(ImageSource.gallery);
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        ),
//      );
//    });
//  }

  TextEditingController _firstnameCtrl = new TextEditingController();
  TextEditingController _lastnameCtrl = new TextEditingController();
  TextEditingController _phoneCtrl = new TextEditingController();
  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _passwordCtrl = new TextEditingController();
  TextEditingController _conpasswordCtrl = new TextEditingController();

 

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_image.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('CustomerProfile/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    String downloadUrl = await snapshotTask.ref.getDownloadURL();
    if (downloadUrl != null) {
      updateInfo.updateProfilePic(downloadUrl.toString(), context).then((val) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
            ModalRoute.withName('/'));
      }).catchError((e) {
        print('upload error $e');
      });
    }
  }

  signUp(BuildContext context) async {
    String birth = '';
    String fname = _firstnameCtrl.text.trim().toString();
    String lname = _lastnameCtrl.text.trim().toString();
    String contact = _phoneCtrl.text.trim().toString();
    String email = _emailCtrl.text.trim().toString();
    String pwd = _passwordCtrl.text.toString();
    String conpwd = _conpasswordCtrl.text.toString();
    setState(() {
      birth = _age.toString();
    });

    if (_formKey.currentState.validate()) {
      if (pwd == conpwd) {
        print('ok');
        _auth.createUserWithEmailAndPassword(email: email, password: pwd).then(
            (currentUser) => Firestore.instance
                    .collection('users')
                    .document(currentUser.user.uid)
                    .setData({
                  'firstname': fname,
                  'lastname': lname,
                  'birth': birth,
                  'email': email,
                  'contact': contact,
                  'uid': currentUser.user.uid,
                  'role': 'user'
                }).then((user) {
                  print('user ok $currentUser');
                  uploadImage(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      ModalRoute.withName('/'));
                }).catchError((e) {
                  print('profile $e');
                }));
      } else {
        print('password not match');
      }
    }
  }

  Widget datetime() {
    return CupertinoDatePicker(
      initialDateTime: DateTime.now(),
      onDateTimeChanged: (DateTime newdate) {
        print(newdate);
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryPage(),
              ),
            );
          },
        ),
        title: Text(
          'ผู้ใช้ทั่วไป',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
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
//                                  _showActionSheet();

                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              new ListTile(
                                                leading: new Icon(
                                                    Icons.photo_camera),
                                                title: new Text("Camera"),
                                                onTap: () async {
                                                  captureImage(
                                                      ImageSource.camera);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              new ListTile(
                                                leading: new Icon(
                                                    Icons.photo_library),
                                                title: new Text("Gallery"),
                                                onTap: () async {
                                                  captureImage(
                                                      ImageSource.gallery);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _firstnameCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ชื่อห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.redAccent,
                            ),
                            hintText: 'ชื่อ',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _lastnameCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'นามสุกลห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.perm_contact_calendar,
                              color: Colors.redAccent,
                            ),
                            hintText: 'นามสกุล',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
//                      Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 20),
//                        child: TextFormField(
//                          controller: _usernameCtrl,
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'ชื่อผู้ใช้ห้ามว่าง';
//                            } else {
//                              return null;
//                            }
//                          },
//                          style: TextStyle(
//                            fontFamily: mali,
//                          ),
//                          decoration: const InputDecoration(
//                            icon: Icon(
//                              Icons.person_outline,
//                              color: Colors.redAccent,
//                            ),
//                            hintText: 'ชื่อผู้ใช้',
//                            hintStyle: TextStyle(
//                              fontSize: 16.0,
//                              color: Colors.black54,
//                            ),
//                          ),
//                        ),
//                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          controller: _phoneCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'เบอร์โทรศัพท์ห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.redAccent,
                            ),
                            hintText: 'ติดต่อ',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
//                      Padding(
//                        padding: const EdgeInsets.symmetric(horizontal: 20),
//                        child: Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: TextFormField(
//                                decoration: const InputDecoration(
//                                  icon: Icon(
//                                    Icons.cake,
//                                    color: Colors.redAccent,
//                                  ),
//                                  hintText: 'วันเกิด',
//                                  hintStyle: TextStyle(
//                                    fontSize: 16.0,
//                                    color: Colors.black54,
//                                  ),
//                                ),
//                              ),
//                            ),
//                            IconButton(
//                              icon: Icon(Icons.calendar_today),
//                              onPressed: () {
//                                _birth();
//                              },
//                            ),
//                          ],
//                        ),
//
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                theme: DatePickerTheme(
                                  containerHeight: 200.0,
                                ),
                                showTitleActions: true,
                                minTime: DateTime(1950, 1, 1),
                                maxTime: DateTime(2021, 12, 31),
                                onConfirm: (date) {
                              print('Confirm $date');
                              _age = '${date.year}/${date.month}/${date.day}';
                              setState(() {});
                            },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 18.0,
                                        color: Colors.blueGrey[200],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          '$_age',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _emailCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'อีเมล์ห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.mail,
                              color: Colors.redAccent,
                            ),
                            hintText: 'อีเมล',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passwordCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'รหัสผ่านห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.redAccent,
                            ),
                            hintText: 'รหัสผ่าน',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          obscureText: true,
                          controller: _conpasswordCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ยืนยันรหัสผ่านห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock_outline,
                              color: Colors.redAccent,
                            ),
                            hintText: 'ยืนยันรหัสผ่าน',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                onPressed: () => signUp(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'สมัครสมาชิก',
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
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'ยกเลิก',
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
                        height: 40.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
