part of 'search_tv_series_bloc.dart';

abstract class SearchTvSeriesEvent extends Equatable {
  const SearchTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OnQueryChangeEvent extends SearchTvSeriesEvent {
  final String query;

  OnQueryChangeEvent(this.query);

  @override
  List<Object> get props => [];
}
