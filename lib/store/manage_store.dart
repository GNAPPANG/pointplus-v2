import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:point_plus_v2/services/new_update_info.dart';
import 'dart:io';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'main_store.dart';
import 'package:path/path.dart';

final mali = 'Mali';
final kalam = 'Kalam';

class ManageStorePage extends StatefulWidget {
  @override
  _ManageStorePageState createState() => _ManageStorePageState();
}

class _ManageStorePageState extends State<ManageStorePage> {
  File _image;
  TextEditingController namemenu = TextEditingController();
  TextEditingController pricectrl = TextEditingController();
  String userID = '';
  final GlobalKey<FormState> _valForm = GlobalKey<FormState>();
  NewUpdateInfo updateInfo = new NewUpdateInfo();
  String productImageUrl ='';

 Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile = await ImagePicker.pickImage(source: imageSource);
      setState(() {
        _image = imageFile;
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_image != null) {
      return Image.file(_image);
    } else {
      return Image.asset('assets/images/iconim.png',
      height: 120,
      );
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

  Future uploadImage(BuildContext context) async {
    String fileName = basename(_image.path);
    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('ProductImage/${fileName.toString()}');
    StorageUploadTask task = firebaseStorageRef.putFile(_image);
    print('task: ${task}');
    StorageTaskSnapshot snapshotTask = await task.onComplete;
    print('snapshotTask: ${snapshotTask}');
    String downloadUrl = await snapshotTask.ref.getDownloadURL();

    print('downloadUrl: ${downloadUrl}');
    setState(() async {
      productImageUrl = await snapshotTask.ref.getDownloadURL();
    });
    if (downloadUrl != null) {
      updateInfo.updateProduct(downloadUrl.toString(), context).then((val) {
        print('ok');
      }).catchError((e) {
        print('upload error ${e}');
      });
    }
  }

  addMenu(BuildContext context) async{
    uploadImage(context);
    String product = namemenu.text.toString();
    String price = pricectrl.text.trim().toString();
   if(_valForm.currentState.validate()){

     print('product: ${product}, price: ${price}');

     FirebaseAuth auth = FirebaseAuth.instance;
     final FirebaseUser user = await auth.currentUser();
     final uid = user.uid.toString();
     print(uid);

     setState(() {
       userID = uid;
     });
   }



   Firestore.instance
      .collection('users')
      .document(userID)
      .collection('products')
      .add({
     "product": product,
     "price": price,
     "productImgUrl": productImageUrl,
   })
        .then((result)=>{

          print('add success')
   })
        .catchError((err){
          print(err);


   });



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
                        onTap: (){
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
                                  onPressed: ()=> addMenu(context),
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
        ],
      ),
    );
  }
}
