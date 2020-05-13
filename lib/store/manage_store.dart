// import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/services/new_update_info.dart';
import 'main_store.dart';
import 'package:path/path.dart' as Path;

final mali = 'Mali';
final kalam = 'Kalam';

class ManageStorePage extends StatefulWidget {
  @override
  _ManageStorePageState createState() => _ManageStorePageState();
}

class _ManageStorePageState extends State<ManageStorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  File _image;
  String filename;
  TextEditingController _menuController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  String userID;
  String imgUrl;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  NewUpdateInfo updateInfo = new NewUpdateInfo();
  String productImageUrl = '';
  bool circular = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    userID = user.uid.toString();
    print('userID: $userID');
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _image = imageFile;
        filename = Path.basename(_image.path);
        print('image : $_image');
      });
    } catch (e) {
      print(e);
    }
  }

  void _chooseImage(BuildContext context) {
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
          FirebaseStorage.instance.ref().child('stores/$userID/products/$filename');
      StorageUploadTask uploadTask = ref.putFile(_image);
      var downloadUrl =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      var url = downloadUrl.toString();
      imgUrl = url.toString();
      print('upload image success');
      print('imgUrl: $imgUrl');
      return 'success';
    } on Exception catch (err) {
      print('upload error: $err');
      return err.toString();
    }
  }

  submitForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      circular = true;
    });

    _uploadImage().then((value) {
      if (value == 'success') {
        String productName = _menuController.text.toString();
        String productPrice = _priceController.text.trim().toString();
        print('getimgurl: $imgUrl');
        Firestore.instance
            .collection('store')
            .document(userID)
            .collection('products')
            .add({
          "product": productName,
          "price": productPrice,
          "productImgUrl": imgUrl,
        }).then((resule) {
          print('success');
          print('$productName, $productPrice, $imgUrl');
          setState(() {
            circular = false;
          });
          final snackBar = SnackBar(
            content: Text('เพิ่มเมนูสำเร็จ!!'),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);

          setState(() {
            _menuController.text = '';
            _priceController.text = '';
            _image = null;
            filename = null;
            imgUrl = '';
          });
        }).catchError((err) {
          print(err);
          setState(() {
            circular = false;
          });
          final snackBar = SnackBar(
            content: Text('ไม่สามารถเพิ่มเมนูได้ กรุณาลองใหม่อีกครั้ง'),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        });
      } else {
        final snackBar = SnackBar(
          content: Text('ไม่สามารถเพิ่มเมนูได้ กรุณาลองใหม่อีกครั้ง'),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 36.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          _chooseImage(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SizedBox(
                            width: 200,
                            height: 160,
                            child: (_image != null)
                                ? Image.file(
                                    _image,
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset('assets/images/iconim.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 36.0,
                      ),
                      TextFormField(
                        controller: _menuController,
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
                        controller: _priceController,
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
                                  onPressed: submitForm,
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
