import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:point_plus_v2/user/profile_user.dart';


final mali = 'Mali';

class ChooseTimePage extends StatefulWidget {
  @override
  _ChooseTimePageState createState() => _ChooseTimePageState();
}

class _ChooseTimePageState extends State<ChooseTimePage> {


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
          'เวลาปิด',
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


            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                use24hFormat: false,
                initialDateTime: _dateTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (dateTime){
                  print(dateTime);
                  setState(() {
                    _dateTime = dateTime;

                  });
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}



