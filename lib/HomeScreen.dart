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
  var currentPage=1;


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
    //String myUrl = "https://randomuser.me/api/?page=1&results=10&seed=abc-";
    String myUrl = "https://randomuser.me/api/?page=${currentPage}&results=10";
    var req = await http.get(Uri.parse(myUrl));
    infos = json.decode(req.body);
    loadedProducts = infos["results"];
    loadedProducts1= infos["results"];
    currentPage++;
   // print("infos is ${infos["results"]}");
    //print(loadedProducts.length);
    // print(loadedProducts[0]["gender"]);
    // print(loadedProducts[0]["email"]);
    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<Favorites>(context);
    final item = fav.items;

    return Scaffold(

      appBar: AppBar(
        title: Text("Users List"),
        actions:  [
          GestureDetector(
            onTap: () async {
              //var l=[];
              // for(int i=0;i<loadedProducts.length;i++){
              //   if(loadedProducts[i]["gender"]=="male"){
              //     l.add(loadedProducts[i]);
              //   }
              // }
              print("current page is ${currentPage}");

              String myUrl = "https://randomuser.me/api/?page=${currentPage}&results=10";
              var req = await http.get(Uri.parse(myUrl));
              var temp = json.decode(req.body);
              currentPage++;
              for(int i = 0; i<temp["results"].length;i++){
                loadedProducts.add(temp['results'][i]);
              }

              setState(() {

              });
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 7),
              child: CircleAvatar(
                child: Icon(Icons.refresh)
              ),
            ),
          ),

          GestureDetector(
            onTap: () async {
              //var l=[];
              // for(int i=0;i<loadedProducts.length;i++){
              //   if(loadedProducts[i]["gender"]=="male"){
              //     l.add(loadedProducts[i]);
              //   }
              // }
              // //print("filtered item is ${l}");

              String myUrl = "https://randomuser.me/api/?gender=male";
              var req = await http.get(Uri.parse(myUrl));
              var temp = json.decode(req.body);


              setState(() {
                loadedProducts=temp['results'];
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
            onTap:() async {
              //var l=[];
              // for(int i=0;i<loadedProducts.length;i++){
              //   if(loadedProducts[i]["gender"]=="female"){
              //     l.add(loadedProducts[i]);
              //   }
              // }
              //print("filtered item is ${l}");
              String myUrl = "https://randomuser.me/api/?gender=female";
              var req = await http.get(Uri.parse(myUrl));
              var temp = json.decode(req.body);



              setState(() {
                loadedProducts=temp["results"];
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
            onTap: () async {
              // var l=[];
              // for(int i=0;i<loadedProducts1.length;i++){
              //
              //     l.add(loadedProducts1[i]);
              //
              // }
              //print("filtered item is ${l}");
              String myUrl = "https://randomuser.me/api/?page=1&results=10&seed=abc-";
              var req = await http.get(Uri.parse(myUrl));
              var temp = json.decode(req.body);


              setState(() {
                loadedProducts=temp['results'];
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
                title: Text("${loadedProducts[index]["name"]["title"]} ${loadedProducts[index]["name"]["first"]} ${loadedProducts[index]["name"]["last"]}"),
                subtitle: Text("${loadedProducts[index]["phone"]}"),
                trailing: item.contains(index)?IconButton(icon: Icon(Icons.favorite, color: Colors.red), onPressed: () {
                  var snackBar = const SnackBar(content: Text('Item Already Added',textAlign: TextAlign.center));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },):
                IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), onPressed: () {
                  fav.add(index);
                    var snackBar = const SnackBar(content: Text('Added to favorites',textAlign: TextAlign.center));
                     ScaffoldMessenger.of(context).showSnackBar(snackBar);

                },)
                // ), onPressed: () async {
                //   fav.add(index);
                //   var snackBar = const SnackBar(content: Text('Added to favorites',textAlign: TextAlign.center));
                //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //
                //   //Navigator.popAndPushNamed(context, CartDetail.routename);
                //  // await Navigator.push(context, MaterialPageRoute(builder: (
                //       //BuildContext context) => FavoriteScreen(loadedProducts1)));
                //
                // }),
              ),
            ),
          );
        },
        itemCount: loadedProducts.length,
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FavoriteScreen(loadedProducts1)));
          },
          icon: const Icon(Icons.arrow_forward_ios),
          label: const Text("Go To Favorites"),
      ),

    );

  }
}
