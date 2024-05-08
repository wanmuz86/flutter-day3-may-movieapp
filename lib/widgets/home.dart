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
  var _movies = [];
  var movieEditingController = TextEditingController();
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
                      flex: 1,
                      child: TextField(
                        controller: movieEditingController,
                        decoration:
                            InputDecoration(hintText: "Enter movie name"),
                      )),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          // var movies = fetchMovies();

                          // value here is what's returned from the function
                          // value here refers to the List<MovieSearch> from API
                          if (movieEditingController.text.length > 2) {
                            FocusScope.of(context).requestFocus(FocusNode());

                            fetchMovies(movieEditingController.text).then((
                                value) =>
                            {
                              setState(() {
                                _movies = value;
                              })
                            });
                          }
                          else {
                            var snackBar = SnackBar(content: Text("Minimum 3 characters required"));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Text("Search Movie")),
                  )
                ],
              ),
              Expanded(
                // by default if I add Expanded it will be flex:1
                // If I dont have expanded flex 0
                child: ListView.builder(
                    // How many rows are there
                    itemCount: _movies.length,
                    // What to show on every row
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.yellow,
                        child: ListTile(
                          title: Text(_movies[index].title),
                          subtitle: Text(_movies[index].year),
                          trailing: Icon(Icons.chevron_right),
                          leading: _movies[index].poster != "N/A" ? Image.network(_movies[index].poster) : SizedBox(),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPage()));
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }

  // Future -> It means that this is an asynchronous method
  // Later, when we call this function either use async - await or use then
  // var movies = async fetchAlbum() , fetchAlbum().then(val=> {))

  // <> -> Type of data returned by this method
  // [] / Array -> List<ClassName>
  // {} / Object -> ClassName
  Future<List<MovieSearch>> fetchMovies(searchText) async {
    // import http
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=$searchText&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      // []-> You will call the 5th method
      // {} -> You will call the 4th method

      // jsonDecode -> import 'dart:convert'
      return MovieSearch.moviesFromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
}
