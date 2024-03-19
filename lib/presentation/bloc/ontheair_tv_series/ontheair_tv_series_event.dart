part of 'ontheair_tv_series_bloc.dart';

abstract class OntheairTvSeriesEvent extends Equatable {
  const OntheairTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class OntheairTvSeriesDidLoad extends OntheairTvSeriesEvent {}
