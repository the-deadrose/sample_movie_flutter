

import 'movie.dart';

class MovieState{

  final bool isLoaded;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final List<Movie> searchMovies;
  final String errorMessage;
  final int page;
  final bool isLoadMore;

  MovieState({
    required this.errorMessage,
    required this.isLoaded,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
    required this.searchMovies,
    required this.page,
    required this.isLoadMore
  });

  MovieState copyWith({
    bool? isLoaded,
    String? errorMessage,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    List<Movie>? searchMovies,
    int? page,
    bool? isLoadMore
  }) {
    return MovieState(
        errorMessage: errorMessage ??  this.errorMessage,
        isLoaded: isLoaded ?? this.isLoaded,
        popularMovies: popularMovies ?? this.popularMovies,
        topRatedMovies: topRatedMovies ?? this.topRatedMovies,
        upcomingMovies: upcomingMovies ?? this.upcomingMovies,
        searchMovies: searchMovies ?? this.searchMovies,
        page: page ?? this.page,
        isLoadMore: isLoadMore ?? this.isLoadMore
    );
  }



}