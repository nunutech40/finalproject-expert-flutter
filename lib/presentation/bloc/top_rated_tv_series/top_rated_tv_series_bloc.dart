import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class TopRatedTvSeriesBloc
    extends Bloc<TopRatedTvSeriesEvent, TopRatedTvSeriesState> {
  GetTopRatedTVSeries _getTopRatedTVSeries;
  TopRatedTvSeriesBloc(this._getTopRatedTVSeries)
      : super(TopRatedTvSeriesEmpty()) {
    on<TopRatedTvSeriesDidLoad>(
      (event, emit) async {
        emit(TopRatedTvSeriesLoading());

        final result = await _getTopRatedTVSeries.execute();
        result.fold(
          (failure) {
            emit(TopRatedTvSeriesError("Server Failure"));
          },
          (data) {
            emit(TopRatedTvSeriesHasData(data));
          },
        );
      },
    );
  }
}
