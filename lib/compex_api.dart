import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ComplexApi extends StatefulWidget {
  const ComplexApi({super.key});

  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> {
var data;
  Future<void> getUserApi()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }else{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Api"),
      ),
      body: Column(
        children: [
             Expanded(
               child: FutureBuilder(future: getUserApi(), builder: (context, snapShot){
                 if(snapShot.connectionState == ConnectionState.waiting){
                   return Text("loading");
                 }else{
                   return ListView.builder(
                       itemCount: data.length,
                       itemBuilder: (context, index){
                     return Card(
                       elevation: 5,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             MyRow(title: "Name", description: data[index]['name'].toString()),
                             MyRow(title: "Email", description: data[index]['email'].toString()),
                             MyRow(title: "Address", description: data[index]['address']['street'].toString()),
                             MyRow(title: "Geo", description: data[index]['address']['geo']['lng'].toString()),


                           ],
                         ),
                       ),
                     );
                   });
                 }
               }),
             )
        ],
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  String title, description;
  MyRow({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
        Text(description, style: const TextStyle(fontSize: 22),)
      ],
    );
  }
}


