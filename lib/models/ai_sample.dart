import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyModel {
  final String title;
  final int age ;

  MyModel({required this.age, required this.title});

// Create a MyModel from Firestore document
  factory MyModel.fromFirestore(DocumentSnapshot <Map < String,dynamic > > document) {
    return MyModel(
      title: document['user name'] ?? 'No title',
      age: document['age'],
    );
  }
}

class userSevices{

  Future<List<MyModel>> getDataMessage() async{
   final data =await FirebaseFirestore.instance.collection("users").get();
   final userMessage = data.docs.map((e) => MyModel.fromFirestore(e)).toList();

  return userMessage;
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: FutureBuilder (
        future:userSevices().getDataMessage() ,
        builder: (context, snapshot) {
         List <MyModel> userMessage = [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available.'));
          }
           List<MyModel> data = snapshot.data! ;
            // for(var user in data){
            //   String name = user.title;
            //   int age = user.age;
            // }
          print( data);

          //dataModel = data ;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var doc = data[index];
              return ListTile(
                 title: Text(doc.title ?? 'No title'),
                 subtitle: Text(doc.age.toString()?? 'No subtitle'),
              );
            },
          );
        },
      ),
    );
  }
}
