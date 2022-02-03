import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical/Favorites.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  //const FavoriteScreen({Key? key}) : super(key: key);
  var fav;
  FavoriteScreen(this.fav);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final loadedItem = Provider.of<Favorites>(context);
    final items = loadedItem.items;
    final wid = MediaQuery.of(context).size.width;
    return Scaffold(
        body:Container(
          height: MediaQuery.of(context).size.height ,

          //height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height),
                //height: MediaQuery.of(context).size.height *0.9,

                child: ListView.builder(
                  itemBuilder: (ctx , index) {
                    return GestureDetector(
                      onTap: () async {
                        //await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen(loadedProducts[index])));

                      },
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("${index+1}"),
                          ),
                          title: Text("${widget.fav[items[index]]["gender"]}"),
                          subtitle: Text("${widget.fav[items[index]]["email"]}"),

                        ),
                      ),
                    );
                  },
                  itemCount: items.length,

                ),
              ),

            ],
          ),
        )
    );
  }
}


