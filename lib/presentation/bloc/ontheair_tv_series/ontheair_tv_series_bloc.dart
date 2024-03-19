
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_tvseries_ontheair.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ontheair_tv_series_event.dart';
part 'ontheair_tv_series_state.dart';

class OntheairTvSeriesBloc
    extends Bloc<OntheairTvSeriesEvent, OntheairTvSeriesState> {
  GetTVSeriesOnTheAir _getTVSeriesOnTheAir;
  OntheairTvSeriesBloc(this._getTVSeriesOnTheAir)
      : super(OntheairTvSeriesEmpty()) {
    on<OntheairTvSeriesDidLoad>(
      (event, emit) async {
        emit(OntheairTvSeriesLoading());

        final result = await _getTVSeriesOnTheAir.execute();
        result.fold((failure) {
          emit(
            OntheairTvSeriesError("Server Failure"),
          );
        }, (data) {
          emit(
            OntheairTvSeriesHasData(data),
          );
        });
      },
    );
  }
}
