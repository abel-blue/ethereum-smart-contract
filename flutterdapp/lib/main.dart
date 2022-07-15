import 'package:flutter/material.dart';
import 'package:flutterdapp/ParentPage.dart';
import 'package:flutterdapp/parentModel.dart';
import 'package:flutterdapp/childModel.dart';
import 'package:provider/provider.dart';
import 'package:flutterdapp/ChildPage.dart';

var password;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => parentModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => childModel(),
        )
      ],
      child: MaterialApp(
        title: 'GPS Tracker Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Demo'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
