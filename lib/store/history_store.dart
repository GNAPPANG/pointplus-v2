import 'package:flutter/material.dart';


final mali = 'Mali';
final kalam = 'Kalam';

class HistoryStorePage extends StatefulWidget {
  @override
  _HistoryStorePageState createState() => _HistoryStorePageState();
}

class _HistoryStorePageState extends State<HistoryStorePage> {


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
                          Container(
                              width: 60.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/images/tay.jpg'),
                                  )
                              )),
                          SizedBox(
                            width: 16.0,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'ID : S12356 ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'mali' ,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                'ให้แต้ม 1 แต้ม',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'mali' ,
                                  fontSize: 14.0,
                                ),
                              ),
                              Text(
                                'วันนี้ 09.30 น.',
                                style: TextStyle(
                                  color: Colors.black,
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
            'ประวัติการทำรายการ',
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