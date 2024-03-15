import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/domain/usecases/get_tvseries_ontheair.dart';
import 'package:flutter/material.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _tvSeriesOnTheAir = <Movie>[];
  List<Movie> get tvSeriesOnTheAir => _tvSeriesOnTheAir;

  RequestState _tvSeriesOnTheAirState = RequestState.Empty;
  RequestState get tvSeriesOnTheAirState => _tvSeriesOnTheAirState;

  var _popularTVSeries = <Movie>[];
  List<Movie> get popularTVSeries => _popularTVSeries;

  RequestState _popularTVSeriesState = RequestState.Empty;
  RequestState get popularTVSeriesState => _popularTVSeriesState;

  var _topRatedTVSeries = <Movie>[];
  List<Movie> get topRatedTVSeries => _topRatedTVSeries;

  RequestState _topRatedTVSeriesState = RequestState.Empty;
  RequestState get topRatedTVSeriesState => _topRatedTVSeriesState;

  String _message = '';
  String get message => _message;

  TVSeriesListNotifier({
    required this.getTVSeriesOnTheAir,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  });

  final GetTVSeriesOnTheAir getTVSeriesOnTheAir;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  Future<void> fetchTVSeriesOnTheAir() async {
    _tvSeriesOnTheAirState = RequestState.Loading;
    notifyListeners();

    final result = await getTVSeriesOnTheAir.execute();
    result.fold(
      (failure) {
        _tvSeriesOnTheAirState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _tvSeriesOnTheAirState = RequestState.Loaded;
        _tvSeriesOnTheAir = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTVSeries() async {
    _popularTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();
    result.fold(
      (failure) {
        _popularTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _popularTVSeriesState = RequestState.Loaded;
        _popularTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTVSeries() async {
    _topRatedTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();
    result.fold(
      (failure) {
        _topRatedTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _topRatedTVSeriesState = RequestState.Loaded;
        _topRatedTVSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
