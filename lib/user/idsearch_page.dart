import 'package:flutter/material.dart';

class IdsearchPage extends StatefulWidget {
  @override
  _IdsearchPageState createState() => _IdsearchPageState();
}

class _IdsearchPageState extends State<IdsearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200]
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20.0),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: "ค้นหา",
                  ),
                ),
              ),
            ),
            SizedBox(width: 20,),
            IconButton(
              icon: Icon(Icons.search,color: Colors.black54,),
              onPressed: (){

              },
            )
          ],
        ),

      ),


    );
  }
}


