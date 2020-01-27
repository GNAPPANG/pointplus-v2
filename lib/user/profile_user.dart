import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  File imageFile;

  _openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Make a Choice!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Gallary'),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }



  _selectImageProfile() {
    debugPrint('profile image');
//    _showChoiceDialog(context);
    //_openCamera(context);
    _openGallary(context);
  }

  int _gValue;

  _imageProfile() {
    if (imageFile == null) {
      return Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage('assets/images/tay.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            _showChoiceDialog(context);
          },
        ),
      );
    } else {
      return Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.file(
              imageFile,
              width: 150,
              height: 150,
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _showChoiceDialog(context);
            },
          ),
        ],
      );
    }
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
            SizedBox(
              height: 24.0,
            ),
            Stack(
              children: <Widget>[
              
                Container(
                  child: Container(
                    child: _imageProfile(),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
            Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      
                      // GestureDetector(
                      //   onTap: () {
                      //     _selectImageProfile();
                      //   },
                      //   child: Container(
                      //       width: 180.0,
                      //       height: 180.0,
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           image: DecorationImage(
                      //             fit: BoxFit.fill,
                      //             image: AssetImage('assets/images/tay.jpg'),
                      //           ))),
                      // ),
                      SizedBox(
                        height: 8.0,
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
                                    return Container(
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height /
                                            3,
                                        child: datetime());
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
                                      '12/12/1996',
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
                                onPressed: () {},
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
