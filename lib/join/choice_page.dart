import 'package:flutter/material.dart';
import 'package:point_plus_v2/store/homestore.dart';

import 'home.dart';


class ChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('user'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomePage(),
              ),);
            },
          ),

          RaisedButton(
            child: Text('store'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomestorePage(),
              ),);
            },
          ),
        ],
      ),
    );
  }
}
