import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreDetail extends StatelessWidget {
  static const routeName = '/store-detail';

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(document['namestore']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.png',
                image: document['proFile'].toString(),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'เมนูทั้งหมด',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('store')
                  .document('${document['uid']}')
                  .collection('products')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('กรุณาลองใหม่อีกครั้ง');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: Visibility(
                        visible: true,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  default:
                    // print('snapshot: ${snapshot.data.documents[0].data}');
                    return snapshot.data.documents.length > 0
                        ? Column(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot document) {
                              return ProductItem(document);
                            }).toList(),
                          )
                        : Center(
                            child: Text('ไม่มีเมนู'),
                          );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final DocumentSnapshot document;

  ProductItem(
    this.document,
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 100,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.png',
                  image: document['productImgUrl'].toString(),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document['product'].toString(),
                    style: TextStyle(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  Text('฿ ${document['price'].toString()}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
