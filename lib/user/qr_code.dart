import 'package:flutter/material.dart';


final mali = 'Mali';

class QrCode extends StatefulWidget {
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode> {
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
                    h: MediaQuery
                        .of(context)
                        .size
                        .height / 7,
                    c: context,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Image.asset(
                    'assets/images/QR.png',
                    width: 300.0,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    'สแกนเพื่อสะสมแต้ม',
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 22.0,
                      fontFamily: 'mali',
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
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



class ShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    var path = Path();
    path.lineTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.8, 0);
    paint.color = Color(0x13FFFFFF);
    canvas.drawPath(path, paint);
    path.close();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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
            'คิวอาร์โค้ด',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontFamily: 'mali',
            ),
          ),
          SizedBox(
              width: 20
          ),
        ],
      ),
    ),
  );
}