import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tv_shows/providers/PTVShows.dart';
import 'package:tv_shows/providers/PTVShowsJson.dart';
import 'package:tv_shows/widgets/CustomCard.dart';

class FavoriteTVShows extends StatefulWidget {
  @override
  State<FavoriteTVShows> createState() => _FavoriteTVShowsState();
}

class _FavoriteTVShowsState extends State<FavoriteTVShows> {
  @override
  Widget build(BuildContext context) {
    List<Results> favorites = Provider.of<PTVShows>(context).favorites;
    return Container(
      child: favorites.isEmpty
          ? Center(
              child: Text(
              "No favorite is added yet, try adding some!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (ctx, index) {
                return CustomCard(
                  id: favorites[index].id,
                  title: favorites[index].name,
                  image: favorites[index].posterPath,
                  description: favorites[index].overview,
                );
              },
            ),
    );
  }
}
