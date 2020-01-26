import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/cupertino.dart';
import 'package:point_plus_v2/join/category_page.dart';

final mali = 'Mali';

class ReuserPage extends StatefulWidget {
  @override
  _ReuserPageState createState() => _ReuserPageState();
}

class _ReuserPageState extends State<ReuserPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstnameCtrl = new TextEditingController();
  TextEditingController _lastnameCtrl = new TextEditingController();
  TextEditingController _usernameCtrl = new TextEditingController();
  TextEditingController _phoneCtrl = new TextEditingController();
  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _passwordCtrl = new TextEditingController();
  TextEditingController _conpasswordCtrl = new TextEditingController();

  _birth() {
    print('date picker');
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
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
                          onTap: (){
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
                  Expanded(child: datetime()),
                ],
              ));
        });
  }

  Future _register() {
    print('register');
    if (_formKey.currentState.validate()) {}
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
                      Container(
                          width: 180.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/upload.png'),
                              ))),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _usernameCtrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ชื่อผู้ใช้ห้ามว่าง';
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(
                            fontFamily: mali,
                          ),
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person_outline,
                              color: Colors.redAccent,
                            ),
                            hintText: 'ชื่อผู้ใช้',
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.cake,
                                    color: Colors.redAccent,
                                  ),
                                  hintText: 'วันเกิด',
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _birth();
                              },
                            ),
                          ],
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
                                onPressed: () {
                                  _register();
                                },
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
