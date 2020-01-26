import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'manage_store.dart';


final mali = 'Mali';
final kalam = 'Kalam';

class MainStorePage extends StatefulWidget {
  @override
  _MainStorePageState createState() => _MainStorePageState();
}

class _MainStorePageState extends State<MainStorePage> {


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
                    height: 20.0,
                  ),
                  Container(
                      width: 180.0,
                      height: 180.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/logocof.jpg'),
                          )
                      )),
                  SizedBox(
                    height: 8.0,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ManageStorePage(),
                      ),);
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          Icon(
                            Icons.add_circle_outline,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'จัดการเมนูร้านค้า',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'mali',

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/coffee.jpg',
                          height: 120.0,
                          width: 130,
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ชื่อเมนู : ลาเต้ร้อน',
                               style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: 'mali',
                              ),
                            ),
                            Text(
                              'ราคา : 75 บาท',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontFamily: 'mali',
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
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

//----------------------------------



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
            'ชื่อร้านค้า',
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