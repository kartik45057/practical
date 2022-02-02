import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Tasks.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _desFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  late String title;
  late String description;
  final List<Map> loadedProducts = [];
  var isLoading = false;

  Future<void> fetchAndSetTasks() async {
    try{

      setState(() {
        isLoading=true;
      });
      var snapshot = await FirebaseFirestore.instance.collection('Tasks').get();
      //print("snapshot of data is ${[...snapshot.docs.map((doc)=> doc.data())]}");

      for(int i=0;i< [...snapshot.docs.map((doc)=> doc.data())].length;i++){

        // print("ph is ${ph}");
        Map m = {
          'title': [...snapshot.docs.map((doc) => doc.data())][i]['title'],
          'description': [
            ...snapshot.docs.map((doc) => doc.data())
          ][i]['description'],
          'id':[...snapshot.docs.map((doc) => doc.data())][i]['id']
        };

        loadedProducts.add(
            m
        );
      }
      setState(() {
        isLoading=false;

      });
      print("length of imageurl is ");
      print("loadedproduct is ${loadedProducts}");
      //

    }catch (error){
      print(error);

    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndSetTasks();


  }

  @override
  void dispose() {
    // TODO: implement dispose
    _desFocusNode.dispose();
    super.dispose();
  }



  Future<void> _saveForm(context) async {
    setState(() {
      isLoading = true;
    });
    print("save");

    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }

    _form.currentState?.save();
    print("save 2 ${title} and description is ${description}");
    Navigator.pop(context);


      try {
        DocumentReference docRef = await FirebaseFirestore.instance.collection(
            'Tasks').add(
            {
              'title': title,
              'description': description,
            }
        );


        await FirebaseFirestore.instance.collection('Tasks').doc(docRef.id).update(
            {
              'title': title,
              'description': description,
              'id':docRef.id,
            }
        );
        Map m = {
          'title': title,
          'description': description,
          'id':docRef.id
        };

        loadedProducts.add(
            m
        );
        setState(() {
          isLoading=false;

        });
      }catch(e){
        print("error is ${e}");
        Navigator.pop(context);
        var snackBar = const SnackBar(content: Text('Something Went Wrong',textAlign: TextAlign.center));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

    // Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return isLoading?
        Scaffold(
          appBar: AppBar(
              title: const Text(
                  "Task Manager"
              )
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
        :Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Manager"
        ),

      ),

      body: loadedProducts.length>0?
          ListView.builder(
              itemBuilder: (context,index){
                return Column(
                  children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text("${index+1}"),
                            ),
                          title: Text("${loadedProducts[index]['title']}"),
                          subtitle: Text("${loadedProducts[index]['description']}"),
                            trailing: GestureDetector(
                              onTap: () async {
                                try{
                                  setState(() {
                                    isLoading=true;
                                  });

                                  FirebaseFirestore docRef = await FirebaseFirestore.instance;
                                  docRef.collection("Tasks").doc(loadedProducts[index]['id'])
                                      .delete();
                                  loadedProducts.removeAt(index);
                                  setState(() {
                                    isLoading=false;
                                  });

                                }catch (error){
                                  throw error;
                                }

                              },
                                child: Icon(Icons.check)
                            ),
                    ),
                        ),
                      ),

                  ],
                );
              },
              itemCount: loadedProducts.length,
          )
          :const Center(
        child: Text("No task added yet"),
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: (){
          showModalBottomSheet(
              context: context,

              isScrollControlled: true,
              builder:(context){
                return Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          Padding(
                            padding: EdgeInsets.only(top: 50.0,bottom: 50,left: 15,right: (MediaQuery.of(context).size.width)/4),
                            child: GestureDetector(
                              child: Icon(Icons.clear),
                                onTap: (){
                                Navigator.pop(context);
                              }
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30.0),
                            child: Text("Add Task",
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                        child: TextFormField(
                          decoration:  InputDecoration(
                              labelText: 'Title',
                            border: OutlineInputBorder(
                              //borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,

                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_desFocusNode);
                          },

                          onSaved: (value) {
                            title = value!;
                          },
                          validator: (value) {
                            if (value!=null?value.isEmpty:true) {
                              return 'Please provide a value.';
                            }
                            return null;
                          },

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
                        child: TextFormField(
                          //initialValue: _initValues['description'],
                          decoration:  InputDecoration(
                              labelText: 'Description',
                            border: OutlineInputBorder(
                              //borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: _desFocusNode,
                          onSaved: (value) {
                            description=value!;

                          },
                          validator: (value) {
                            if (value!=null?value.isEmpty:true) {
                              return 'Please enter a description.';
                            }
                            if (value!=null?value.length < 10:true) {
                              return 'Should be at least 10 characters long.';
                            }
                            return null;
                          },
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                _saveForm(context);

                              },
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("ADD_TASK"),
                              )
                          ),
                        ],
                      )

                    ],
                  ),
                );
              }
          );
        },
        label: const Text("Add Task"),
      ),


    );
  }
}
