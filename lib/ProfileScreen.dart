import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  var item;
  ProfileScreen(this.item);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Account"),
        ),
        body:Column(
          children: [
            Container(
              width: double.infinity,

              height: MediaQuery.of(context).size.height * 0.3,
              color: Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Icon(Icons.person,size: 150,color: Colors.white,)
                    Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.all(15),
                      child:Image.network("${widget.item["picture"]["large"]}")
                    ),
                    Text(widget.item["login"]["username"],style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),),

                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
