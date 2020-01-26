import 'package:flutter/material.dart';

import 'main_store.dart';


final mali = 'Mali';
final kalam = 'Kalam';

class ManageStorePage extends StatefulWidget {
  @override
  _ManageStorePageState createState() => _ManageStorePageState();
}

class _ManageStorePageState extends State<ManageStorePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => MainStorePage(),
              ),
            );
          },
        ),
        title: Text(
          'จัดการเมนูร้านค้า',
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
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 36.0,
                    ),
                    Image.asset(
                      'assets/images/iconim.png',
                      width: 120.0,
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                    TextFormField(
                      style: TextStyle(fontFamily: mali, fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: 'ชื่อเมนู',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'กรุณากรอกชื่อผเมนู';
                        } else if (value.length <= 20) {
                          return 'กรอกชื่อเมนูให้ถูกต้อง';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 8.0,
                    ),

                    TextFormField(
                      style: TextStyle(fontFamily: mali, fontSize: 12.0),
                      decoration: InputDecoration(
                        hintText: 'ราคา',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'กรุณากรอกราคา';
                        } else if (value.length <= 20) {
                          return 'กรอกราคาให้ถูกต้อง';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'เพื่มลงเมนู',
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

        ],
      ),
    );
  }


}
