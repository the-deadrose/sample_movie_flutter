




import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui/models/movie.dart';
import '../api.dart';
import '../models/movie_state.dart';
import '../services/movie_service.dart';

final movieProvider = StateNotifierProvider.family<MovieNotifier, MovieState, Categories>((ref, Categories cat)
=> MovieNotifier(
    MovieState(errorMessage: '', isLoaded: false,
        upcomingMovies: [],
        topRatedMovies: [],
        popularMovies: [],
        searchMovies: [],
        page: 1,
        isLoadMore: false
    ),
    cat
)
);

class MovieNotifier extends StateNotifier<MovieState> {
  final Categories category;
  MovieNotifier(super.state, this.category){
    getMovieByCategory();
  }

  Future<void> getMovieByCategory() async {
    if (category == Categories.upcoming) {
      state = state.copyWith(isLoaded: state.isLoadMore ? false: true, errorMessage: '');      final response = await MovieService.getMovieCategory(
          apiPath: Api.upcomingMovie, page: state.page);
      response.fold((l) {
        state = state.copyWith(isLoaded: false, errorMessage: l, page: state.page);
      }, (r) {
        state =
            state.copyWith(isLoaded: false, errorMessage: '', upcomingMovies: [...state.upcomingMovies, ...r]);
      });
    } else if (category == Categories.popular) {
      state = state.copyWith(isLoaded: state.isLoadMore ? false: true, errorMessage: '');
      final response = await MovieService.getMovieCategory(
          apiPath: Api.popularMovie, page: state.page);
      response.fold((l) {
        state = state.copyWith(isLoaded: false, errorMessage: l);
      }, (r) {
        state =
            state.copyWith(isLoaded: false, errorMessage: '', popularMovies: [...state.popularMovies, ...r]);
      });
    } else {
      state = state.copyWith(isLoaded: state.isLoadMore ? false: true, errorMessage: '');      final response = await MovieService.getMovieCategory(
          apiPath: Api.topRatedMovie, page: state.page);
      response.fold((l) {
        state = state.copyWith(isLoaded: false, errorMessage: l);
      }, (r) {
        state =
            state.copyWith(isLoaded: false, errorMessage: '', topRatedMovies: [...state.topRatedMovies, ...r]);
      });
    }

  }


  void loadMore(){
    state = state.copyWith(
      page: state.page + 1,
      isLoadMore: true
    );
    getMovieByCategory();
  }


}