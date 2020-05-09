import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:point_plus_v2/user/store_detail.dart';

class StoreItem extends StatelessWidget {
  final DocumentSnapshot document;

  StoreItem(
    this.document,
  );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          StoreDetail.routeName,
          arguments: document,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
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
              SizedBox(height: 5),
              Text(
                document['namestore'].toString(),
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
