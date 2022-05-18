import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_shows/providers/PTVShowsJson.dart';
import 'package:tv_shows/config/Urls.dart';

class PTVShows with ChangeNotifier {
  List<Results> _showList = [];
  List<Results> get showList {
    return [..._showList];
  }

  List<Results> _favorites = [];
  List<Results> get favorites {
    return [..._favorites];
  }

  List<Results> _searchedTVShows = [];
  List<Results> get searchedTVShows {
    return [..._searchedTVShows];
  }

  Future<void> storeFavorites() async {
    final favs = PTVShowsItems().toJson(_favorites);
    String jsonString = jsonEncode({"list": favs});
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("favoriteTVShows", jsonString);
    notifyListeners();
  }

  Future<void> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString("favoriteTVShows");
    if (jsonString != null) {
      PTVShowsItems ptvs =
          PTVShowsItems.fromJson(jsonDecode(jsonString)["list"]);
      _favorites = ptvs.results;
    } else {
      _favorites = [];
    }
  }

  void addToFavorites(Results tvItem) {
    _favorites.add(tvItem);
    storeFavorites();
  }

  void removeFromFavorites(Results tvItem) {
    _favorites.remove(tvItem);
    storeFavorites();
  }

  Future<void> getAllItems() async {
    final url = Uri.parse(BASE_URL);

    try {
      final response = await get(url);
      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        PTVShowsItems ptvs = PTVShowsItems.fromJson(extractedData);
        _showList = ptvs.results;
        getFavorites();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchByName(search) async {
    final apiKey = "6cd5215cc4c0bf0f6e1e11db724068f7";
    print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
    final searchURL = Uri.parse(
        "https://api.themoviedb.org/3/search/tv?query=$search&api_key=$apiKey");
    try {
      final response = await get(searchURL);

      if (response.statusCode == 200) {
        final searchedData = json.decode(response.body) as Map<String, dynamic>;
        PTVShowsItems searchedPTVS = PTVShowsItems.fromJson(searchedData);
        _searchedTVShows = searchedPTVS.results;
      }
    } catch (e) {
      print(e);
    }
  }
}
