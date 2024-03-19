part of 'ontheair_tv_series_bloc.dart';

abstract class OntheairTvSeriesState extends Equatable {
  const OntheairTvSeriesState();

  @override
  List<Object> get props => [];
}

class OntheairTvSeriesEmpty extends OntheairTvSeriesState {}

class OntheairTvSeriesLoading extends OntheairTvSeriesState {}

class OntheairTvSeriesHasData extends OntheairTvSeriesState {
  final List<Movie> result;

  OntheairTvSeriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class OntheairTvSeriesError extends OntheairTvSeriesState {
  final String message;
  OntheairTvSeriesError(this.message);

  @override
  List<Object> get props => [];
}
