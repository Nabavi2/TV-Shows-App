import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/PTVShows.dart';
import 'package:tv_shows/screens/AllTVShows.dart';
import 'package:tv_shows/screens/FavoriteTVShows.dart';
import 'package:tv_shows/screens/SearchScreen.dart';
import 'package:tv_shows/widgets/CustomCard.dart';

class AllScreen extends StatefulWidget {
  @override
  _AllScreenState createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  bool _isLoading = false;

  bool _isInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<PTVShows>(context, listen: false).getAllItems().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
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
          toolbarHeight: size.height * 0.07,
          backgroundColor: Color(0xff18162e),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.search),
            )
          ]),
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
