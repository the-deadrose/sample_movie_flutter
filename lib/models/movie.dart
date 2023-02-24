enum Categories{
  popular,
  top_rated,
  upcoming
}


class Movie{

  final String title;
  final String poster_path;
  final String backdrop_path;
  final int id;
  final String overview;
  final String release_date;
  final String vote_average;



  const Movie({
    required this.id,
    required this.title,
    required this.backdrop_path,
    required this.overview,
    required this.poster_path,
    required this.release_date,
    required this.vote_average
  });


  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
        id: json['id'] ,
        title: json['title'] ?? '',
        backdrop_path: json['backdrop_path'] ?? '',
        overview: json['overview'] ?? '',
        poster_path: 'https://image.tmdb.org/t/p/w600_and_h900_bestv2${json['poster_path']}',
        release_date: json['release_date'] ?? '',
        vote_average: '${json['vote_average']}'
    );
  }



}


