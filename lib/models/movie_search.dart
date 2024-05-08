// 1 Create the class

class MovieSearch {
// 2) Create the properties of the class
// This we used our naming convention / camelCase
final String title;
final String year;
final String poster;
final String imdbId;
final String type;

// 3) Create the constructor
MovieSearch({required this.title, required this.year,
  required this.poster,
required this.imdbId, required this.type});

// 4) Create JSON to Object transformer

factory MovieSearch.fromJson(Map<String,dynamic> json){
  return MovieSearch(title: json["Title"],
      year: json["Year"],
      poster: json["Poster"],
      imdbId: json["imdbID"],
      type: json["Type"]);
}
}