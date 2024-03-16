import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_tv_series_state.dart';
part 'search_tv_series_event.dart';

class SearchTvSeriesBloc
    extends Bloc<SearchTvSeriesEvent, SearchTvSeriesState> {
  final SearchTVSeries _searchTVSeries;

  SearchTvSeriesBloc(this._searchTVSeries) : super(SearchTvSeriesEmpty()) {
    on<OnQueryChangeEvent>(
      (event, emit) async {
        final query = event.query;

        emit(SearchTvSeriesLoading());
        final result = await _searchTVSeries.execute(query);

        result.fold((failure) {
          emit(
            SearchTvSeriesError(failure.message),
          );
        }, (data) {
          emit(SearchTvSeriesHasdata(data));
        });
      },
      transformer: debounce(Duration(milliseconds: 500)),
    );
  }
}
