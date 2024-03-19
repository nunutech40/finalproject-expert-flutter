import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/movie.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc
    extends Bloc<PopularTvSeriesEvent, PopularTvSeriesState> {
  final GetPopularTVSeries _getPopularTVSeries;
  PopularTvSeriesBloc(this._getPopularTVSeries)
      : super(PopularTvSeriesEmpty()) {
    on<PopularTvSeriesDidLoad>(
      (event, emit) async {
        emit(PopularTvSeriesEmpty());

        final result = await _getPopularTVSeries.execute();

        result.fold((failure) {
          emit(PopularTvSeriesError("Server Failure"));
        }, (data) {
          emit(PopularTvSeriesHasData(data));
        });
      },
    );
  }
}
