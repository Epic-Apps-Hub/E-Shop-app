import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/constants.dart';
import "package:path_provider/path_provider.dart";
import 'package:shop_app/models/favorite.dart';
import 'package:shop_app/models/order.dart';
import 'package:shop_app/views/WelcomeScreen.dart';
import './blocs/blocObserver.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;
  Bloc.observer = SimpleBlocObserver();

  Hive
    ..init(appDocPath)
    ..registerAdapter(FavoriteAdapter())
    ..registerAdapter(OfflineOrderAdapter());
  Hive.openBox('myBox');
  Hive.openBox('OrdersBox');
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mainColor, statusBarBrightness: Brightness.dark));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
