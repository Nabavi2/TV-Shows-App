import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/PTVShows.dart';
import 'package:tv_shows/screens/AllTVShows.dart';
import 'package:tv_shows/screens/FavoriteTVShows.dart';
import 'package:tv_shows/screens/SearchScreen.dart';

class AllScreen extends StatefulWidget {
  @override
  _AllScreenState createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      Provider.of<PTVShows>(context, listen: false).getAllItems().then((_) {});
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.height * 0.065,
          backgroundColor: Color(0xff18162e),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.favorite),
              ),
              Tab(
                icon: Icon(Icons.search),
              )
            ],
            indicatorColor: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff18162e),
        body: TabBarView(children: [
          AllTVShows(),
          FavoriteTVShows(),
          SearchScreen(),
        ]),
      ),
    );
  }
}
