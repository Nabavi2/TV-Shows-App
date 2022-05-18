import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/PTVShows.dart';
import 'package:tv_shows/widgets/CustomCard.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('Start searching');
  final _form1 = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  bool _isLoading = false;
  Future<void> _saveform() async {
    String searchTitle = _title.text;
    try {
      await Provider.of<PTVShows>(context, listen: false)
          .searchByName(searchTitle)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        return value;
      });
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final searchedList = Provider.of<PTVShows>(context).searchedTVShows;
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        backgroundColor: Color(0xff171538),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _saveform();
              setState(() {
                ListTile(
                  title: TextField(
                    controller: _title,
                    decoration: InputDecoration(
                      hintText: 'Type movie name',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );

                // else {
                //   customIcon = const Icon(Icons.search);
                //   customSearchBar = const Text('Tab to the input');
                // }
              });
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
      ),
      backgroundColor: Color(0xff18162e),
      body: ListView.builder(
        itemCount: searchedList.length,
        itemBuilder: (ctx, index) {
          return CustomCard(
            id: searchedList[index].id,
            title: searchedList[index].name,
            image: searchedList[index].posterPath,
            description: searchedList[index].overview,
          );
        },
      ),
    );
  }
}
