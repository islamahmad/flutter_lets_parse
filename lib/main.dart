import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  List data = await getJSON();
  runApp(
    MaterialApp(
      title: 'Let\'s parse JSON',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          title: Text('Let\'s parse JSON'),
        ),
        body: Center(
        child: ListView.builder(

         itemCount: data.length,
          padding: EdgeInsets.all(10.5),
          itemBuilder: (BuildContext context,int position){
           return Column(
             children: <Widget>[
             Divider(
               height: 2.2,
             ),
               ListTile(
                 title: Text(data[position]['title'],style: TextStyle(fontSize: 15.9),
                 ),
                 subtitle: Text(data[position]['body'],style: TextStyle(fontSize: 10.9)
                 ),
                 leading: CircleAvatar(child: Text(data[position]['id'].toString()
                 ),
                 ),
                 onTap: () {
                   showOnTapDB(context, data[position]['body']);
                   }
               ),
               ],
           );
          }
          ,
        ),
        )

      ),
    ),
  );
}

void showOnTapDB(BuildContext context,  String message){
    var alert = AlertDialog(
      title: Text('Alert Dialog'),
      content: Text('$message'),
      actions: <Widget>[
        Center(child: FlatButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text('OK'),),),
      ],
    );
    //showDialog(context: context,child: alert);
    showDialog(context: context, builder: (context) => alert);
}

Future<List> getJSON() async {
  String apiURL = 'https://jsonplaceholder.typicode.com/posts';
  http.Response response = await http.get(apiURL);
  return json.decode(response.body);
  //return 'hello';
}
