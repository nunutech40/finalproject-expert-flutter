import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:flutter/foundation.dart';

class TopRatedTvSeriesNotifier extends ChangeNotifier {
  final GetTopRatedTVSeries getTopRatedTVSeries;

  TopRatedTvSeriesNotifier({required this.getTopRatedTVSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
