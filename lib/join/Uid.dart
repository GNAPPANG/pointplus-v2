import 'package:firebase_auth/firebase_auth.dart';
class Uid {
  String uid = inputData();

  static inputData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid.toString();
    print(uid);

    return uid;
    // here you write the codes to input the data into firestore
  }
}