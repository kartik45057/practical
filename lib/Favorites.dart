import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites with ChangeNotifier {



var _items = [];


List get items {
  return _items;
}

  getItems() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    String? fav = _preferences.getString("favorites");
    var list = (fav==null)?[]:json.decode("fav");
    _items = list;

    notifyListeners();
  }

  add(int index) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _items.add(index);
    _preferences.setString("favorites", json.encode(_items));
    notifyListeners();
  }
}