import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/PTVShows.dart';
import 'package:tv_shows/widgets/CustomCard.dart';

class AllTVShows extends StatefulWidget {
  // const AllTVShows({ Key? key }) : super(key: key);

  @override
  State<AllTVShows> createState() => _AllTVShowsState();
}

class _AllTVShowsState extends State<AllTVShows> {
  @override
  Widget build(BuildContext context) {
    final ptvShowsList = Provider.of<PTVShows>(context).showList;
    return ListView.builder(
      itemCount: ptvShowsList.length,
      itemBuilder: (ctx, index) {
        return CustomCard(
          id: ptvShowsList[index].id,
          title: ptvShowsList[index].name,
          image: ptvShowsList[index].posterPath,
          description: ptvShowsList[index].overview,
        );
      },
    );
  }
}
