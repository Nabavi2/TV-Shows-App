import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/PTVShows.dart';
import 'package:tv_shows/screens/AllScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PTVShows(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Color(0xff100e2a),
        ),
        home: AllScreen(),
      ),
    );
  }
}
