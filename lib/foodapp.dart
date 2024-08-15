import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class food extends StatefulWidget {
  const food({super.key});

  @override
  State<food> createState() => _foodState();
}

class _foodState extends State<food> {
  final postController=TextEditingController();
  bool loading=false;
  final databaseRef=FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Food App"),
          backgroundColor: Colors.blue,

        ),
        body:

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),

              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  hintText: 'Whats in your mind'
                ),
              ),

              SizedBox(
                height: 30,
              ),

    ElevatedButton(onPressed: (){

    databaseRef.child('2').set({  // if u change child value from 2 to 3 then it will store your
    //data in row 3.  if u use same child value then your text
    //will override on your previous text
    'title' : postController.text.toString(),
    'id' :1


    }).then((value){

    void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2), // Adjust the duration as needed
    ),
    );
    }
    showToast(context, "Posted");



    }).onError((error, stackTrace){


    });

    },
    child: Text("Add"))

    ],



    )


        ));
  }
}


