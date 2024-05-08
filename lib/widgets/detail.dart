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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail page"),),
      body: Text("Detail page for ${widget.imdbId}"),
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
