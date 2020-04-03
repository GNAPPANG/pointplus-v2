import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:point_plus_v2/store/manage_store.dart';

final mali = 'Mali';
final kalam = 'Kalam';

class MainStorePage extends StatefulWidget {
  @override
  _MainStorePageState createState() => _MainStorePageState();
}

class _MainStorePageState extends State<MainStorePage> {
  String userID = '';

  inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);
    setState(() {
      userID = uid.toString();
    });
  }

  manageStore() {
    print('managestore');
    Navigator.of(context).push(_createRoute(screen: ManageStorePage()));
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(userID)
                .snapshots(),
            builder: (context, sn) {
              var img = sn.data['proFile'];
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    imgPro(img: img),
                    SizedBox(height: 20),
                    btnManageStore(),
                    SizedBox(height: 20),
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection("users")
                            .document(userID)
                            .collection('pressure')
                            .orderBy("create_at", descending: true)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError)
                            return new Text('Error: ${snapshot.error}');
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: new Text('Loading...'));
                            default:
                              return new ListView(
                                children: snapshot.data.documents
                                    .map((DocumentSnapshot document) {
                                  return store(
                                      img: 'assets/images/01.jpg',
                                      product: document['product'].toString(),
                                      price: document['price'].toString());
                                }).toList(),
                              );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget imgPro({img}) {
    return Container(
      width: 180.0,
      height: 180.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 5),
        image: DecorationImage(
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget btnManageStore() {
    return FlatButton(
      onPressed: manageStore,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_circle_outline, color: Colors.black54),
          SizedBox(width: 10),
          Text(
            'จัดการเมนูร้านค้า',
            style: TextStyle(
              fontSize: 18.0,
              fontFamily: mali,
            ),
          ),
        ],
      ),
    );
  }

  Widget store({
    img,
    product,
    price,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            )),
          ),
          SizedBox(width: 20),
          Column(
            children: <Widget>[
              Text(
                'ชื่อร้านค้า: ${product} ',
                style: TextStyle(fontFamily: mali, fontSize: 20),
              ),
              SizedBox(height: 30),
              Text(
                'ราคา: ${price} ',
                style: TextStyle(fontFamily: mali, fontSize: 20),
              ),
            ],
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
          SizedBox(width: 20),
        ],
      ),
    ),
  );
}

Route _createRoute({screen}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
