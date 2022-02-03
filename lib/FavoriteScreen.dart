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
      appBar: AppBar(
        title: Text("Favorites"),
      ),
        body:ListView.builder(
          itemBuilder: (ctx , index) {
            return GestureDetector(
              onTap: () async {
                //await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ProfileScreen(loadedProducts[index])));

              },
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(

                    title: Text("${widget.fav[items[index]]["name"]["title"]} ${widget.fav[items[index]]["name"]["first"]} ${widget.fav[items[index]]["name"]["last"]}"),
                    subtitle: Text("${widget.fav[items[index]]["email"]}"),
                    trailing: GestureDetector(
                      onTap: (){
                        print("original index ${index}");
                        print("item index ${items[index]}");
                        loadedItem.remove(items[index]);
                      },
                        child: Icon(Icons.clear)
                    ),

                  ),
                ),
              ),
            );
          },
          itemCount: items.length,

        )
    );
  }
}


