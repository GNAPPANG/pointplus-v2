
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/profile_user.dart';

import 'choice_page.dart';

final kalam = 'Kalam';
final mali = 'Mali';


class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,  color: Colors.black54),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProfileUser(),
            ),);
          },
        ),
        title: Text(
          'นโยบายทางธุรกิจ',
          style: TextStyle(
            fontFamily: 'mali' ,
            color: Colors.black54,
          ),
        ),
      ),

    );
  }
}
