import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../profile_store.dart';


final mali = 'Mali';

class ProvinceReproPage extends StatefulWidget {
  @override
  _ProvinceReproPageState createState() => _ProvinceReproPageState();
}

class _ProvinceReproPageState extends State<ProvinceReproPage> {
  void _onDropItemSelected(String newValueSelected) {
  }

  var _provice = ['กาญจนบุรี', 'กรุงเทพมหานคร', 'นครปฐม'];
  var _proviceItemSelected = 'กรุงเทพมหานคร';

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
                builder: (context) => ProfileStorePage(),
              ),
            );
          },
        ),
        title: Text(
          'จังหวัด',
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
                padding: const EdgeInsets.all(32.0),
                child: Column(

                  children: <Widget>[
                    DropdownButton<String>(
                      isExpanded: true,
                      items: _provice.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Center(
                            child: Text(
                              dropDownStringItem,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        _onDropItemSelected(newValueSelected);
                      },
                      value: _proviceItemSelected,
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


