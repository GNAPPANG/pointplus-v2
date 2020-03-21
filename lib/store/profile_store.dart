import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/join/login_page.dart';
import 'package:point_plus_v2/store/prostore/address_repro.dart';
import 'package:point_plus_v2/store/prostore/mail_repro.dart';
import 'package:point_plus_v2/store/prostore/name_repro.dart';
import 'package:point_plus_v2/store/prostore/password_repro.dart';
import 'package:point_plus_v2/store/prostore/phone_repro.dart';


final mali = 'Mali';
final kalam = 'Kalam';

class ProfileStorePage extends StatefulWidget {
  @override
  _ProfileStorePageState createState() => _ProfileStorePageState();
}

class _ProfileStorePageState extends State<ProfileStorePage> {
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

  String open ="00:00 น.";
  String close ="00:00 น.";


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

  _province() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
              color: Colors.white,
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          top: 20,
                        ),
                        child: InkWell(
                          onTap: () {
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
                  Expanded(
                    child: CupertinoPicker(
                      backgroundColor: Colors.white,
                      onSelectedItemChanged: (val) {
                        //Navigator.of(context).pop();
                      },
                      itemExtent: 35,
                      children: <Widget>[
                        Text("กรุงเทพ"),
                        Text("กาญจนบุรี"),
                        Text("สมุทรสาคร"),
                        Text("กรุงเทพ"),
                        Text("กาญจนบุรี"),
                        Text("กรุงเทพ"),
                        Text("กาญจนบุรี"),
                        Text("สมุทรสาคร"),
                        Text("กรุงเทพ"),
                        Text("กาญจนบุรี"),
                        Text("กรุงเทพ"),
                        Text("กาญจนบุรี"),
                        Text("สมุทรสาคร"),
                        Text("กรุงเทพ"),
                        Text("กาญจนบุรี"),
                      ],
                    ),
                  ),
                ],
              ));
        });
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
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
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
                  SizedBox(
                    height: 16.0,
                  ),

//                  Container(
//                      width: 180.0,
//                      height: 180.0,
//                      decoration: BoxDecoration(
//                          shape: BoxShape.circle,
//                          image: DecorationImage(
//                            fit: BoxFit.fill,
//                            image: AssetImage('assets/images/logocof.jpg'),
//                          )
//                      )),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'ID : S12356',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18.0,
                      fontFamily: 'mali',
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
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
                              builder: (context) => NameReproPage(),
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
                                  'ชื่อร้าน',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  'Coffee Time',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'mali',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 185,
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
                          _province();
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
                                  'จังหวัด',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  'กรุงเทพมหานคร',
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
                              builder: (context) => AddressReproPage(),
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
                                  'ที่อยู่',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '11 พชรเกษม แขวงหนองค้างพลู เขตหนองแขม ',
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
                              builder: (context) => PhoneReproPage(),
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
                                  'ติดต่อ',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  '0224734680',
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
                              builder: (context) => MailReproPage(),
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
                                  'อีเมล',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  'coffeetime@gmail.com',
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
                              builder: (context) => PasswordReproPage(),
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
                                return Container(
                                    color: CupertinoColors.white,
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
                                              padding: const EdgeInsets.only(
                                                right: 20,
                                                top: 20,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  print('done');
                                                  // ดึงวันที่ใส่ใน textformfield
                                                  print('${open}');
                                                  setState(() {
                                                    open = (initialtimer.inHours).toString() + ':' +initialtimer.inMinutes.remainder(60).toString() + ' น.';
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
                                          ],
                                        ),
                                        Expanded(child: time()),
                                      ],
                                    ));
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
                                  'เวลาเปิด',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  open,
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
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext builder) {
                                return Container(
                                    color: CupertinoColors.white,
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
                                              padding: const EdgeInsets.only(
                                                right: 20,
                                                top: 20,
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  print('done');
                                                  // ดึงวันที่ใส่ใน textformfield
                                                  print('${close}');
                                                  setState(() {
                                                    close = (initialtimer.inHours).toString() + ':' +initialtimer.inMinutes.remainder(60).toString() + ' น.';
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
                                          ],
                                        ),
                                        Expanded(child: time()),
                                      ],
                                    ));
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
                                  'เวลาปิด',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'mali',
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  close,
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

//
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
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {},
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
        ],
      ),
    );
  }
}
