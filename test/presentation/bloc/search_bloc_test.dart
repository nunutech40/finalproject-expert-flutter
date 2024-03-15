
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:mockito/annotations.dart';

import '../provider/movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
}