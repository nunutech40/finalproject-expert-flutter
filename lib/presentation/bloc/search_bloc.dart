import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  
  final SearchMovies _searchMovies;


  SearchBloc(this._searchMovies) : super(SearchEmpty());
}
