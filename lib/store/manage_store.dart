
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/services/new_update_info.dart';
import 'dart:io';
import 'main_store.dart';
import 'package:path/path.dart' as Path;

final mali = 'Mali';
final kalam = 'Kalam';

class ManageStorePage extends StatefulWidget {
  @override
  _ManageStorePageState createState() => _ManageStorePageState();
}

class _ManageStorePageState extends State<ManageStorePage> {
  File _image;
  String filename;
  TextEditingController namemenu = TextEditingController();
  TextEditingController pricectrl = TextEditingController();
  String userID = '';
  String imgUrl;
  final GlobalKey<FormState> _valForm = GlobalKey<FormState>();
  NewUpdateInfo updateInfo = new NewUpdateInfo();
  String productImageUrl = '';
  bool circular = false;

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _image = imageFile;
        filename = Path.basename(_image.path);
      });
    } catch (e) {
      print(e);
    }
  }

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text("Camera"),
                  onTap: () async {
                    captureImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text("Gallery"),
                  onTap: () async {
                    captureImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  // ignore: missing_return
  Future<String> _uploadImage() async {
    try {
      StorageReference ref =
          FirebaseStorage.instance.ref().child('stores/$userID/$filename');
      StorageUploadTask uploadTask = ref.putFile(_image);
      var downloadUrl =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = downloadUrl.toString();
      setState(() {
        imgUrl = url.toString();
      });
      print('upload success');
      print('url: $url');
      return url;

    } on Exception catch (err) {
      print('upload error: $err');
      return err.toString();
    }
  }

  addMenu() async {
    setState(() {
      circular = true;
    });
    _uploadImage();
    String product = namemenu.text.toString();
    String price = pricectrl.text.trim().toString();
    if (_valForm.currentState.validate()) {
      FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseUser user = await auth.currentUser();
      final uid = user.uid.toString();
      print(uid);

      setState(() {
        userID = uid;
      });

      print('getimgurl: $imgUrl');
      Firestore.instance
          .collection('users')
          .document(userID)
          .collection('products')
          .add({
        "product": product,
        "price": price,
        "productImgUrl": imgUrl,
      })
          .then((resule){
        print('success');
        print('$product, $price, $imgUrl');
        setState(() {
          circular = false;
        });
      })
          .catchError((err) {
        print(err);
        setState(() {
          circular = false;
        });
      });
    }




  }

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
                child: Form(
                  key: _valForm,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 36.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showActionSheet(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            width: 400,
                            height: 200,
                            child: (_image != null)
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset('assets/images/iconim.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 36.0,
                      ),
                      TextFormField(
                        controller: namemenu,
                        style: TextStyle(fontFamily: mali, fontSize: 12.0),
                        decoration: InputDecoration(
                          hintText: 'ชื่อเมนู',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ชื่อร้านค้าห้ามว่าง';
                          } else if (value.length <= 1) {
                            return 'ชื่อร้านค้าอย่างน้อย 2 ตัวอักษร';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: pricectrl,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontFamily: mali, fontSize: 12.0),
                        decoration: InputDecoration(
                          hintText: 'ราคา',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'ราคาห้ามว่าง';
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: RaisedButton(
                                  onPressed: addMenu,
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
          ),
          Center(
            child: Visibility(
              visible: circular,
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
