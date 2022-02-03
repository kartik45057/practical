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
   // print(" dhjbh djhhj ${prefs.getString("favorites")}");
    var fav = prefs.getString("favorites");
   // print("shbh djhbhj ${fav}");

    var list = json.decode(fav!);
    //print("list ishbhudb ${list}");
    _items = list;

    notifyListeners();
  }

  add(int index) async {
    //SharedPreferences _preferences = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    if(!_items.contains(index)){
      _items.add(index);
      prefs.setString("favorites", json.encode(_items));
      notifyListeners();
    }

  }

  remove(int index) async {
    //SharedPreferences _preferences = await SharedPreferences.getInstance();
    try{
      final SharedPreferences prefs = await _prefs;
      print("items are ${index}");
      // for(int i=0;i<_items.length;i++){
      //   if(_items[i] == index){
      //
      //     print("djj ${i}");
      //   }
      // }

      _items.remove(index);

      //_items.remove(index);
      print("items are dsdd ${items.length}");
      print("items dasass dsdd ${items}");
      prefs.setString("favorites", json.encode(_items));

    }catch(e){

    }
    notifyListeners();
  }
}