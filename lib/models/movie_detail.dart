import 'rating.dart';
// 1) Create the class
class MovieDetail {
  // 2) Create the properties
  final String title;
  final String poster;
  final String imdbId;
  final String type;
  final String year;
  final String genre;
  final String? actors;
  final String plot;
  final String released;
  final String director;
  final List<Rating> ratings;
  
  // 3) Generate the constructor

  MovieDetail(
      {required this.title,
      required this.poster,
      required this.imdbId,
      required this.type,
      required this.year,
      required this.genre,
        this.actors,
      required this.plot,
      required this.released,
      required this.director,
      required this.ratings});

  // 4) fromJson method (JSON to Object transformer)

factory MovieDetail.fromJson(Map<String,dynamic> json){
  return MovieDetail(title: json["Title"],
      poster: json["Poster"],
      imdbId: json["imdbID"],
      type: json["Type"],
      year: json["Year"],
      genre: json["Genre"],
      plot: json["Plot"],
      released: json["Released"],
      director: json["Director"],
      actors: json["Actors"],
    ratings:Rating.ratingsFromJson(json["Ratings"])
  
  );
}
}
