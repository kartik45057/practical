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
          title: Text("${widget.item["name"]["first"]} ${widget.item["name"]["last"]}"),
        ),
        body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.start,
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
                    Text(widget.item["login"]["username"],style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                    ),),

                  ],
                ),
              ),
            ),

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    //height: 100,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                        child: Text( "Email:- ${widget.item["email"]}",style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black

                        ),),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    //height: 100,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                        child: Text( "cell:- ${widget.item["cell"]}",style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black

                        ),),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    //height: 100,
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 8),
                        child:RichText(
                          text: TextSpan(
                            //text: 'Hello ',
                            //style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(text: "${widget.item["location"]["street"]["number"]}", style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400
                              )),
                              TextSpan(text: '\n\n${widget.item["location"]["street"]["name"]},  ${widget.item["location"]["city"]}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,

                                  )
                              ),
                              TextSpan(text: '\n${widget.item["location"]["state"]},  ${widget.item["location"]["country"]} - ${widget.item["location"]["postcode"]} \n\nPh :- ${widget.item["phone"]} '

                                  ,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,

                                  )
                              ),
                              TextSpan(text: '\n\nD.O.B :- ${widget.item["dob"]["date"]},'

                                  ,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,

                                  )
                              ),
                              TextSpan(text: '\n\nAge :- ${widget.item["dob"]["age"]},'

                                  ,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,

                                  )
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),

          ],
        )
    );
  }
}
