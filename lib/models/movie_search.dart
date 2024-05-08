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

// If the API has a [], add the 5th step, If your api {}, stop at step 4
// 5) Array of Json to List of Object transformer
  static List<MovieSearch> moviesFromJson(dynamic json ){
  // The word "Search" is the key from the API / change it to what your API return it to you
    var searchResult = json["Search"];
    // Create an empty list, the sze of the list is indetermined
    List<MovieSearch> results = List.empty(growable: true);
// If there is a result from API
    if (searchResult != null){
// I will go through each of the results and add it to the List
      searchResult.forEach((v)=>{
        results.add(MovieSearch.fromJson(v))
      });
      return results;
    }
    return results;
  }


}