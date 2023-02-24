import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie_state.dart';
import '../services/movie_service.dart';


final searchProvider = StateNotifierProvider.autoDispose<SearchNotifier, MovieState>((ref)
=> SearchNotifier(
  MovieState(errorMessage: '', isLoaded: false,
      upcomingMovies: [],
      topRatedMovies: [],
      popularMovies: [],
      searchMovies: [],
    isLoadMore: false,
    page: 1
  ),

)
);

class SearchNotifier extends StateNotifier<MovieState> {
  SearchNotifier(super.state);

  Future<void> getSearchMovie(String searchText) async {
    final response = await MovieService.getSearchMovie(searchText: searchText);
    response.fold((l) {
      state = state.copyWith(isLoaded: false, errorMessage: l);
    }, (r) {
      state =
          state.copyWith(isLoaded: false, errorMessage: '', searchMovies: r);
    });
  }

}