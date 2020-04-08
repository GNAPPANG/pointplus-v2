import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';

final mali = 'Mali';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  profile() {
    Navigator.of(context).push(_createRoute(screen: ProfileUser()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: Text(
              'หน้าแรก',
              style: TextStyle(fontFamily: mali),
              textAlign: TextAlign.center,
            )),
            GestureDetector(
              onTap: profile,
              child: Icon(
                Icons.account_circle,
                size: 45,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80.0,
                    child: RaisedButton(
                      onPressed: () {
                        print("kkkkk");
                      },
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
                                  fontFamily: 'mali',
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                'สะสมครบ 10 แต้ม แลกฟรี 1 แก้ว',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'mali',
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                'เมื่อวาน 09.30 น.',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'mali',
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
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

Route _createRoute({screen}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
