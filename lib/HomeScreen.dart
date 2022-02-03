import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practical/FavoriteScreen.dart';
import 'package:practical/Favorites.dart';
import 'dart:convert';

import 'package:practical/ProfileScreen.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var infos;
  var loadedProducts1=[];
  var loadedProducts=[];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var v  = Provider.of<Favorites>(context);
    v.getItems();
  }

  @override
  void initState() {
    super.initState();

    getData();

  }

  getData() async {
    String myUrl = "https://randomuser.me/api/?page=1&results=10&seed=abc-";
    var req = await http.get(Uri.parse(myUrl));
    infos = json.decode(req.body);
    loadedProducts = infos["results"];
    loadedProducts1= infos["results"];
    print("infos is ${infos["results"]}");
    print(loadedProducts.length);
    print(loadedProducts[0]["gender"]);
    print(loadedProducts[0]["email"]);
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<Favorites>(context);
    //final products = loadedItem.items;

    return Scaffold(

      appBar: AppBar(
        title: Text("Users List"),
        actions:  [
          GestureDetector(
            onTap: (){
              var l=[];
              for(int i=0;i<loadedProducts.length;i++){
                if(loadedProducts[i]["gender"]=="male"){
                  l.add(loadedProducts[i]);
                }
              }
              //print("filtered item is ${l}");

              setState(() {
                loadedProducts=l;
              });
            },
            child: const Padding(
                padding: EdgeInsets.only(right: 7),
              child: CircleAvatar(
                child: Text("M"),
              ),
            ),
          ),
          GestureDetector(
            onTap:(){
              var l=[];
              for(int i=0;i<loadedProducts.length;i++){
                if(loadedProducts[i]["gender"]=="female"){
                  l.add(loadedProducts[i]);
                }
              }
              //print("filtered item is ${l}");

              setState(() {
                loadedProducts=l;
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 7.0),
              child: CircleAvatar(
                child: Text("F"),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              var l=[];
              for(int i=0;i<loadedProducts1.length;i++){

                  l.add(loadedProducts1[i]);

              }
              //print("filtered item is ${l}");

              setState(() {
                loadedProducts=l;
              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 7.0),
              child: CircleAvatar(
                child: Text("N"),
              ),
            ),
          )
        ],

      ),
      body: ListView.builder(
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (
                  BuildContext context) => ProfileScreen(loadedProducts[index])));

            },
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("${index+1}"),
                ),
                title: Text("${loadedProducts[index]["gender"]}"),
                subtitle: Text("${loadedProducts[index]["email"]}"),
                trailing: IconButton(icon: Icon(Icons.favorite_border, color: Colors.red,), onPressed: () async {
                  fav.add(index);
                  var snackBar = const SnackBar(content: Text('Added to favorites',textAlign: TextAlign.center));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  //Navigator.popAndPushNamed(context, CartDetail.routename);
                  await Navigator.push(context, MaterialPageRoute(builder: (
                      BuildContext context) => FavoriteScreen(loadedProducts1)));

                }),
              ),
            ),
          );
        },
        itemCount: loadedProducts.length,
      ),

    );

  }
}
