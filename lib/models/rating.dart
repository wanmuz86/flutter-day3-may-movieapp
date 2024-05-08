class Rating {
  final String source;
  final String value;

  Rating({required this.source, required this.value});

  factory Rating.fromJson(Map<String,dynamic> json){
    return Rating(source: json["Source"], value: json["Value"]);
  }

  static List<Rating> ratingsFromJson(dynamic json ){
    var ratings = json;
    List<Rating> results = List.empty(growable: true);

    if (ratings != null){
      ratings.forEach((v)=>{
        results.add(Rating.fromJson(v))
      });
      return results;
    }
    return results;
  }



}