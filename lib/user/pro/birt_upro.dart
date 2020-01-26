import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../profile_user.dart';





final mali = 'Mali';

class BirtUproPage extends StatefulWidget {



  @override
  _BirtUproPageState createState() => _BirtUproPageState();

}

class _BirtUproPageState extends State<BirtUproPage> {
  void _onDropItemSelected(String newValueSelected) {

  }

  DateTime _dateTime = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileUser(),
              ),
            );
          },
        ),
        title: Text(
          'วันเกิด',
          style: TextStyle(
            fontFamily: 'mali',
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_dateTime == null ? 'ยังไม่มีการเลือกอะไรเลย'
                : _dateTime.toString()),
            RaisedButton(
              color: Colors.redAccent,
              child: Text(
                  'เลือกวันที่',
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() :
                  _dateTime,
                  firstDate: DateTime(1930),
                  lastDate: DateTime(2021),
                ).then((date){
                  setState(() {
                    _dateTime = date;
                  });
                });
              } ,
            ),
//          SizedBox(
//            height: 200,
//            child: CupertinoDatePicker(
//              use24hFormat: true,
//              initialDateTime: _dateTime,
//              mode: CupertinoDatePickerMode.time,
//              onDateTimeChanged: (dateTime){
//                print(dateTime);
//                setState(() {
//                  _dateTime = dateTime;
//
//                });
//              },
//            ),
//          ),

          ],
        ),
      ),
    );
  }
}

