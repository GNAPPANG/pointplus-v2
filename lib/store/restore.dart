import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/join/category_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:point_plus_v2/services/new_update_info.dart';
import 'package:point_plus_v2/store/homestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart';

final mali = 'Mali';
final kalam = 'Kalam';

class RestorePage extends StatefulWidget {
  @override
  _RestorePageState createState() => _RestorePageState();
}

class _RestorePageState extends State<RestorePage> {
  File _image;
  String storeOpen = '00.00';
  String storeClose = '00.00';
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

  GlobalKey<ScaffoldState> key = GlobalKey(debugLabel: "scaffoldKey");

  final _formKey = GlobalKey<FormState>();

  Duration initialtimer = new Duration();
  int selectitem = 1;
  String imgUrl;

  FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _passwordCtrl = new TextEditingController();
  TextEditingController _conpasswordCtrl = new TextEditingController();
  TextEditingController _namestoreCtrl = new TextEditingController();
  TextEditingController _phoneCtrl = new TextEditingController();
  TextEditingController _addressCtrl = new TextEditingController();

  bool isLoading = false;

  Future uploadImage(BuildContext context, String uid) async {
    if (_image == null) {
      return;
    }
    String fileName = basename(_image.path);

    try {
      StorageReference ref = FirebaseStorage.instance
          .ref()
          .child('/stores/$uid/imageProfile/${fileName.toString()}');
      StorageUploadTask uploadTask = ref.putFile(_image);
      var downloadUrl =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = downloadUrl.toString();
      imgUrl = url.toString();
      print('upload image success');
      print('imgUrl: $imgUrl');
      return 'success';
    } on Exception catch (err) {
      print('upload error: $err');
      return err.toString();
    }
  }

  signIn(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String email = _emailCtrl.text;
    String password = _passwordCtrl.text;
    String conpassword = _conpasswordCtrl.text;
    String namestore = _namestoreCtrl.text;
    String phone = _phoneCtrl.text;
    String address = _addressCtrl.text;

    if (password == conpassword) {
      setState(() {
        isLoading = true;
      });
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((currentUser) {
        print('currentUser: ${currentUser.user}');
        uploadImage(context, currentUser.user.uid).then((value) {
          Firestore.instance
              .collection('store')
              .document(currentUser.user.uid)
              .setData({
            'proFile': imgUrl,
            'email': email,
            'namestore': namestore,
            'phone': phone,
            'address': address,
            'open': storeOpen,
            'close': storeClose,
            'role': 'store',
            'uid': currentUser.user.uid,
            'status' : 'p',
          }).then((value) {
            Firestore.instance
                .collection('accounts')
                .document(currentUser.user.uid)
                .setData({
              'role': 'store',
              'uid': currentUser.user.uid,
            }).then((value) {
              // setState(() {
              //   isLoading = false;
              // });
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomestorePage()),
                  ModalRoute.withName('/'));
            });
          });
        });
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });
        print('profile $e');
      });
    }
  }

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
          'ผู้ประกอบการร้านค้า',
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
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _namestoreCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ชื่อร้านห้ามว่าง';
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
                            hintText: 'ชื่อร้าน',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Row(
                          children: <Widget>[
//                            Expanded(
//                              child: TextFormField(
//                                decoration: const InputDecoration(
//                                  icon: Icon(
//                                    Icons.check_circle,
//                                    color: Colors.redAccent,
//                                  ),
//                                  hintText: 'เวลาเปิด',
//                                  hintStyle: TextStyle(
//                                    fontSize: 16.0,
//                                    color: Colors.black54,
//                                  ),
//                                ),
//                              ),
//                            ),
                            Expanded(
                              child: Text('$storeOpen น.'),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.access_time,
                                size: 30,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height /
                                              3,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 20,
                                                      top: 20,
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          storeOpen = (initialtimer
                                                                      .inHours)
                                                                  .toString() +
                                                              ':' +
                                                              initialtimer
                                                                  .inMinutes
                                                                  .remainder(60)
                                                                  .toString();
                                                        });
                                                        print('done');
                                                        // ดึงวันที่ใส่ใน textformfield

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
                                                ],
                                              ),
                                              Expanded(child: time()),
                                            ],
                                          ));
                                    });
                              },
                            ),
//                            Expanded(
//                              child: TextFormField(
//                                decoration: const InputDecoration(
//                                  icon: Icon(
//                                    Icons.cancel,
//                                    color: Colors.redAccent,
//                                  ),
//                                  hintText: 'เวลาปิด',
//                                  hintStyle: TextStyle(
//                                    fontSize: 16.0,
//                                    color: Colors.black54,
//                                  ),
//                                ),
//                              ),
//                            ),
                            Expanded(
                              child: Text('$storeClose น.'),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.access_time,
                                size: 30,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height /
                                              3,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 20,
                                                      top: 20,
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        print('done');

                                                        setState(() {
                                                          storeClose = (initialtimer
                                                                      .inHours)
                                                                  .toString() +
                                                              ':' +
                                                              initialtimer
                                                                  .inMinutes
                                                                  .remainder(60)
                                                                  .toString();
                                                        });
                                                        // ดึงวันที่ใส่ใน textformfield

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
                                                ],
                                              ),
                                              Expanded(child: time()),
                                            ],
                                          ));
                                    });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _addressCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ที่อยู่ห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.redAccent,
                            ),
                            hintText: 'ที่อยู่',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                onPressed: () => signIn(context),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: !isLoading
                                    ? Text(
                                        'สมัครสมาชิก',
                                        style: TextStyle(
                                          fontFamily: mali,
                                          fontSize: 14.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
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
