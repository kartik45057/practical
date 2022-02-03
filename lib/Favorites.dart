import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites with ChangeNotifier {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

var _items = [];


List get items {
  return _items;
}

  Future getItems() async {
   // SharedPreferences _preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    print(" dhjbh djhhj ${prefs.getString("favorites")}");
    var fav = prefs.getString("favorites");
    print("shbh djhbhj ${fav}");

    var list = json.decode(fav!);
    print("list ishbhudb ${list}");
    _items = list;

    notifyListeners();
  }

  add(int index) async {
    //SharedPreferences _preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    _items.add(index);
    prefs.setString("favorites", json.encode(_items));
    notifyListeners();
  }
}