import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_app_may/widgets/detail.dart';

import '../models/movie_search.dart';
import 'package:http/http.dart' as http; // it was exported as a object

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _movies = [
    {
      "Title": "Harry Potter and the Deathly Hallows: Part 2",
      "Year": "2011",
      "imdbID": "tt1201607",
      "Type": "movie",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BMGVmMWNiMDktYjQ0Mi00MWIxLTk0N2UtN2ZlYTdkN2IzNDNlXkEyXkFqcGdeQXVyODE5NzE3OTE@._V1_SX300.jpg"
    },
    {
      "Title": "Harry Potter and the Sorcerer's Stone",
      "Year": "2001",
      "imdbID": "tt0241527",
      "Type": "movie",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BNmQ0ODBhMjUtNDRhOC00MGQzLTk5MTAtZDliODg5NmU5MjZhXkEyXkFqcGdeQXVyNDUyOTg3Njg@._V1_SX300.jpg"
    },
    {
      "Title": "Harry Potter and the Chamber of Secrets",
      "Year": "2002",
      "imdbID": "tt0295297",
      "Type": "movie",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BMjE0YjUzNDUtMjc5OS00MTU3LTgxMmUtODhkOThkMzdjNWI4XkEyXkFqcGdeQXVyMTA3MzQ4MTc0._V1_SX300.jpg"
    },
    {
      "Title": "Harry Potter and the Prisoner of Azkaban",
      "Year": "2004",
      "imdbID": "tt0304141",
      "Type": "movie",
      "Poster":
          "https://m.media-amazon.com/images/M/MV5BMTY4NTIwODg0N15BMl5BanBnXkFtZTcwOTc0MjEzMw@@._V1_SX300.jpg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Movie app"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex:1,
                      child: TextField(decoration: InputDecoration(hintText: "Enter movie name"),)),
                  Expanded(
                    child: ElevatedButton(onPressed: (){},
                        child: Text("Search Movie")),
                  )
                ],
              ),
              Expanded(
                // by default if I add Expanded it will be flex:1
                // If I dont have expanded flex 0
                child: ListView.builder(
                  // How many rows are there
                    itemCount:_movies.length,
                    // What to show on every row
                    itemBuilder: (context, index){
                      return ListTile(
                      title: Text(_movies[index]["Title"]!),
                        subtitle: Text(_movies[index]["Year"]!),
                        trailing: Icon(Icons.chevron_right),
                        leading: Image.network(_movies[index]["Poster"]!),
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage()));
                        },
                      );
                    }),
              )
            ],
          ),
        )
    );
  }

  // Future -> It means that this is an asynchronous method
  // Later, when we call this function either use async - await or use then
  // var movies = async fetchAlbum() , fetchAlbum().then(val=> {))

  // <> -> Type of data returned by this method
  // [] / Array -> List<ClassName>
  // {} / Object -> ClassName
  Future<List<MovieSearch>> fetchMovies() async {
    // import http
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=Harry&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // []-> You will call the 5th method
      // {} -> You will call the 4th method

      // jsonDecode -> import 'dart:convert'
      return MovieSearch.moviesFromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
}
