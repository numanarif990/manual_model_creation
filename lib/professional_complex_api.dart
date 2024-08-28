import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/products_model.dart';

class ProfessionalComplexApi extends StatefulWidget {
  const ProfessionalComplexApi({super.key});

  @override
  State<ProfessionalComplexApi> createState() => _ProfessionalComplexApiState();
}

class _ProfessionalComplexApiState extends State<ProfessionalComplexApi> {
  Future<ProductsModel> getProducts() async {
    final response = await http
        .get(Uri.parse("https://api.artic.edu/api/v1/artworks/search?q=cats"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProfessionalComplexApi"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
                future: getProducts(),
                builder: (context, snapShot) {
                  if(snapShot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapShot.data!.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(snapShot.data!.data!.first.title.toString()),
                                  Text(snapShot.data!.data!.first.apiLink.toString()),

                              FutureBuilder(
                              future: getProducts(), // Your data fetching function
                          builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                          return const Text('No data available');
                          } else {
                          try {
                          return Text(snapShot.data!.data!.first.id.toString());
                          } catch (e) {
                          return Text('Error loading image: $e');
                          }
                          }
                          },
                          )
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
