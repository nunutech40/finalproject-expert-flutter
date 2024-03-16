part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesState extends Equatable {
  SearchTvSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTvSeriesLoading extends SearchTvSeriesState {}

class SearchTvSeriesEmpty extends SearchTvSeriesState {}

class SearchTvSeriesError extends SearchTvSeriesState {
  final String message;
  SearchTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvSeriesHasdata extends SearchTvSeriesState {
  final List<Movie> result;

  SearchTvSeriesHasdata(this.result);

  @override
  List<Object> get props => [result];
}
