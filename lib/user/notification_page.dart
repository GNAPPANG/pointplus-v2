import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final mali = 'Mali';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  appBars(
                    h: MediaQuery.of(context).size.height / 7,
                    c: context,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                appBars(
                  h: MediaQuery.of(context).size.height / 7,
                  c: context,
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: RaisedButton(
                      onPressed: () {
                        print("kkkkk");
//                  Navigator.push(context, MaterialPageRoute(
//                    builder: (context) => RestorePage(),
//                  ),);
                      } ,
                      color: Colors.grey[200],
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/logostore.png',
                            width: 60.0,
                          ),
                          SizedBox(
                            width: 24.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Coffee Time',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'mali' ,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                'สะสมครบ 10 แต้ม แลกฟรี 1 แก้ว',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'mali' ,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                'เมื่อวาน 09.30 น.',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'mali' ,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
//                          Icon(
//                            Icons.delete_outline,
//                            color: Colors.black54,
//                            size: 32,
//                          ),
                        ],
                      ),

                    ),
                  ),
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}



Widget appBars({h, c}) {
  return Container(
    height: h,
    color: Colors.redAccent,
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'แจ้งเตือน',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: 'mali',
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    ),
  );
}
