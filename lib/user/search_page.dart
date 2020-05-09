import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      backgroundColor: Colors.redAccent,
      title: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.grey[200]
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20.0),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.black54),
                  hintText: "ค้นหา",
                ),
              ),
            ),
          ),
          SizedBox(width: 20,),
          IconButton(
            icon: Icon(Icons.search,color: Colors.black54,),
            onPressed: (){
              print('search');
            },
          )
        ],
      ),

    ),


    );
  }
}


