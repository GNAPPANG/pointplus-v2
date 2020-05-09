import 'package:flutter/material.dart';
import 'package:point_plus_v2/join/home.dart';
import 'package:point_plus_v2/user/transfer_point.dart';
import 'package:point_plus_v2/user/use_point.dart';

final mali = 'Mali';

class Point extends StatelessWidget {
  final dynamic data;
  Point(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          data.data['store_name'],
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
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/placeholder.png',
                      image: data.data['store_photo_url'].toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Text(
                  //   'สถานะ: เปิด',
                  //   style: TextStyle(
                  //     color: Colors.black45,
                  //     fontSize: 16.0,
                  //     fontFamily: 'mali',
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8.0,
                  // ),
                  // Text(
                  //   'สถานที่: บางบอน3 กรุงเทพมหานคร',
                  //   style: TextStyle(
                  //     color: Colors.black45,
                  //     fontSize: 16.0,
                  //     fontFamily: 'mali',
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8.0,
                  // ),
                  // Text(
                  //   'Tel: 0897653495',
                  //   style: TextStyle(
                  //     color: Colors.black45,
                  //     fontSize: 16.0,
                  //     fontFamily: 'mali',
                  //   ),
                  // ),
                  // Image.asset(
                  //   'assets/images/star.png',
                  //   width: 160.0,
                  // ),
                  SizedBox(height: 20),
                  // Text(
                  //   'คะแนนทั้งหมด ' +
                  //       data.data['store_points'].toString() +
                  //       ' คะแนน',
                  //   style: TextStyle(
                  //     fontFamily: mali,
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(UsePoint.routeName, arguments: data);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => UsePoint(),
                            //   ),
                            // );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            'ใช้แต้ม',
                            style: TextStyle(
                              fontFamily: mali,
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0,
                          ),
                          color: Colors.redAccent,
                          elevation: 3.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TransferPoint(
                                  storeID: data.data['store_id'],
                                ),
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            'โอนแต้ม',
                            style: TextStyle(
                              fontFamily: mali,
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2.0,
                          ),
                          color: Colors.redAccent,
                          elevation: 3.0,
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
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
