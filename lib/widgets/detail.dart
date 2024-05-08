import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app_may/models/movie_detail.dart';
import 'package:http/http.dart' as http;
class DetailPage extends StatefulWidget {
  final String imdbId;
  DetailPage({required this.imdbId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  MovieDetail? _movie;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void loadData(){
    fetchMovie().then((value) => {
      setState(() {
       _movie = value;
      })
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail page"),),
      body: _movie == null ? Center(child: CircularProgressIndicator()): Center(
        child: SingleChildScrollView(
     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(_movie!.title, style: TextStyle(fontSize: 32),),  // I WILL USE ! because I am sure moview will be there
              SizedBox(height: 8,),
              Text(_movie!.year),
              SizedBox(height: 8,),
              Image.network(_movie!.poster),
              SizedBox(height: 8,),
              Text(_movie!.director),
              SizedBox(height: 8,),
              Text(_movie!.actors ?? ""),
              SizedBox(height: 8,),
              Text(_movie!.released),
              SizedBox(height: 8,),
              Text(_movie!.genre),
              SizedBox(height: 8,),
              Text(_movie!.plot , textAlign: TextAlign.center,),
              SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }

  // Future means it is an asynchronous method
  // <> (return type) = {} => ClassName
  Future<MovieDetail> fetchMovie() async {
    // To add http import
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?i=${widget.imdbId}&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // {} -> Call the 4th method fromJson
      // import dart:convert
      return MovieDetail.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
