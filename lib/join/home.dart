import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:point_plus_v2/user/transfer_point.dart';
import '../user/qr_code.dart';
import '../user/main_page.dart';
import '../user/my_point.dart';
import '../user/notification_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final mali = 'Mali';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedItem = 0;

  final _pageOption = [
    MainPage(),
    MyPoint(),
    QrCode(),
    TransferPoint(),
    NotificationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        color: Colors.redAccent,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  Icons.home,
                  size: 35,
                  color: Colors.black54,
              ),
              Text(
                'หน้าหลัก',
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 10.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  Icons.star_border,
                  size: 35,
                  color: Colors.black54
              ),
              Text(
                'แต้มของฉัน',
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 10.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  FontAwesomeIcons.qrcode,
                  size: 35,
                  color: Colors.black54
              ),
              Text(
                'QR Code',
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 10.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  Icons.forward,
                  size: 35,
                  color: Colors.black54
              ),
              Text(
                  'โอนแต้ม',
                style: TextStyle(
                  fontFamily: mali,
                  fontSize: 10.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                  Icons.textsms,
                  size: 35,
                  color: Colors.black54
              ),
              Text(
                  'แจ้งเตือน',
                style: TextStyle(
                fontFamily: mali,
                fontSize: 10.0,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              ),
            ],
          ),
        ],
        onTap: (int index) {
          debugPrint("CurrentIndex is $index");
          setState(() {
            _selectedItem = index;
          });
        },
      ),
      body: _pageOption[_selectedItem],
    );
  }
}

//----------------------------------
class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();
    path.lineTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.8, 0);
    paint.color = Colors.transparent;
    canvas.drawPath(path, paint);
    path.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
