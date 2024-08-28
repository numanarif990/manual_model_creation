import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<photos> photosList = [];

  Future<List<photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        photos Photos = photos(title: i["title"], thumbnailUrl: i["thumbnailUrl"], id: i["id"]);
        photosList.add(Photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manual Models"),
      ),
      body: Column(
        children: [
          FutureBuilder(future: getPhotos(), builder: (context, snapShot) {
            return Expanded(
              child: ListView.builder(
                itemCount: photosList.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(photosList[index].thumbnailUrl),
                          ),
                          title: Text("ID No:"+photosList[index].id.toString()),
                          subtitle: Text(photosList[index].title),
                        ),
                      ),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }
}

class photos {
  String title, thumbnailUrl;
  int id;

  photos({required this.title, required this.thumbnailUrl, required this.id});
}
