import 'package:flutter/material.dart';
import 'package:point_plus_v2/join/home.dart';
import 'package:point_plus_v2/splash_screen.dart';
import 'package:point_plus_v2/store/homestore.dart';
import 'package:point_plus_v2/user/store_detail.dart';
import 'package:point_plus_v2/user/use_point.dart';

import 'join/login_page.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'point plus',
        theme: ThemeData(
          fontFamily: 'Mali',
          primaryColor: Colors.red,
        ),
        routes: <String, WidgetBuilder>{
          '/user': (BuildContext context) => HomePage(),
          '/login': (BuildContext context) => LoginPage(),
          '/store': (BuildContext context) => HomestorePage(),

          //
          StoreDetail.routeName: (ctx) => StoreDetail(),
          UsePoint.routeName: (ctx) => UsePoint(),
        },
        home: SplashScreen(),
        color: Colors.redAccent,
      ),
    );
