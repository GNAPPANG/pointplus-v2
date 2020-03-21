import 'package:flutter/material.dart';
import 'package:point_plus_v2/animation_loading.dart';
import 'package:point_plus_v2/store/homestore.dart';
import 'package:point_plus_v2/store/main_store.dart';

import 'join/login_page.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'point plus',
        home: LoginPage(),
      ),
    );
