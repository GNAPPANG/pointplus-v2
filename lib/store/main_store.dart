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
    print(userID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ชื่อร้านค้า',
          style: TextStyle(fontFamily: mali),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(userID)
                    .snapshots(),
                builder: (context, sn) {
                  if (!sn.hasData) {
                    return Visibility(
                      visible: true,
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      imgPro(img: sn.data['proFile']),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: manageStore,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add_circle_outline,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'จัดการเมนูร้าน',
                              style: TextStyle(
                                fontFamily: mali,
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection("users")
                              .document(userID)
                              .collection('products')
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
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: snapshot.data.documents
                                      .map((DocumentSnapshot document) {
                                    return store(
                                      img: document['productImgUrl'].toString(),
                                      product: document['product'].toString(),
                                      price: document['price'].toString(),
                                    );
                                  }).toList(),
                                );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
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

  Widget store({
    String img,
    String product,
    String price,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        children: <Widget>[
          Container(
            width: 150,
            height: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(width: 20),
          Column(
            children: <Widget>[
              Text(
                'ชื่อร้านค้า: $product ',
                style: TextStyle(fontFamily: mali, fontSize: 20),
              ),
              SizedBox(height: 30),
              Text(
                'ราคา: $price ',
                style: TextStyle(fontFamily: mali, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
